import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:ahmoma_app/data/models/user.dart';
import 'package:ahmoma_app/data/requests/login_request.dart';
import 'package:ahmoma_app/data/responses/login_response.dart';
import 'package:ahmoma_app/utils/constants/api_constants.dart';
import 'package:ahmoma_app/utils/local_storage/app_local_storages.dart';

class ApiClient {
  static final ApiClient _singleton = ApiClient._internal();

  factory ApiClient() {
    return _singleton;
  }

  ApiClient._internal() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.contentType = Headers.jsonContentType; // Nếu backend yêu cầu JSON
    // _dio.options.contentType = Headers.formUrlEncodedContentType; // Nếu backend yêu cầu x-www-form-urlencoded
    _dio.options.connectTimeout = const Duration(minutes: 1);
    _dio.options.receiveTimeout = const Duration(minutes: 1);

    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      final accessToken = await AppLocalStorage().read('token');

      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers["Authorization"] = "Bearer $accessToken";
      }
      handler.next(options);
    }));
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final HttpClient client = HttpClient(context: SecurityContext(withTrustedRoots: false));
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

      return client;
    };
  }

  final _dio = Dio();

  Future<Map<String, dynamic>> requestGet(String path, {Map<String, dynamic>? query, bool enableRefreshToken = true, Map<String, String>? headers}) async {
    Map<String, dynamic> data;
    try {
      Options? options;

      if (headers != null) {
        options = Options(headers: headers);
      }

      data = (await _dio.get(path, queryParameters: query, options: options)).data;
    } on DioException catch (e) {
      data = _getRequestError(e);
    }

    if (enableRefreshToken && data['code'] == 401) {
      if (await _refreshToken()) {
        data = await requestGet(path, query: query, enableRefreshToken: false);
      }
    }

    return data;
  }

  Future<Map<String, dynamic>> requestPost(String path, Map<String, dynamic> body, {bool enableRefreshToken = true, Map<String, String>? headers}) async {
    Map<String, dynamic> data;
    try {
      Options? options;

      if (headers != null) {
        options = Options(headers: headers);
      }

      data = (await _dio.post(path, data: body, options: options)).data;
    } on DioException catch (e) {
      data = _getRequestError(e);
    }

    if (enableRefreshToken && data['code'] == 401) {
      if (await _refreshToken()) {
        data = await requestPost(path, body, enableRefreshToken: false);
      }
    }

    return data;
  }

  Future<bool> _refreshToken() async {
    String refreshToken = await AppLocalStorage().read('refresh_token');
    String userInfo = await AppLocalStorage().read('user_info') ?? '';
    String userName = '';

    if (userInfo.isEmpty) {
      userName = User.fromJson(json.decode(userInfo)).username ?? '';
    }

    if (refreshToken.isEmpty || userName.isEmpty) {
      return false;
    }

    // LoginRequest request = LoginRequest(username: userName, refreshToken: refreshToken);
    LoginRequest request = LoginRequest(email: userName);
    Map<String, dynamic> data;

    try {
      data = (await _dio.post(loginPath, data: request.toJson())).data;
    } on DioException catch (e) {
      data = _getRequestError(e);
    }

    LoginResponse response = LoginResponse.fromJson(data);

    if (response.accessToken != null) {
      await AppLocalStorage().save(key: 'token', value: response.accessToken ?? "");
      // await AppPreference().saveRefreshToken(response.data?.refreshToken ?? "");

      return true;
    }

    return false;
  }

  Map<String, dynamic> _getRequestError(DioException e) {
    var error = <String, dynamic>{};

    if (e.response != null && e.response!.data is Map) {
      error = e.response!.data;
    } else {
      error["code"] = HttpStatus.internalServerError;
    }

    return error;
  }

  Future<Map<String, dynamic>> uploadFile(String path, File file, {Map<String, dynamic>? data, bool enableRefreshToken = true, Map<String, String>? headers}) async {
    Map<String, dynamic> responseData;

    try {
      Options? options;

      if (headers != null) {
        options = Options(headers: headers);
      }

      FormData formData = FormData.fromMap({
        'file': MultipartFile.fromFileSync(file.path),
      });

      responseData = (await _dio.post(path, data: formData, options: options)).data;
    } on DioException catch (e) {
      responseData = _getRequestError(e);
    }

    if (enableRefreshToken && responseData['code'] == 401) {
      if (await _refreshToken()) {
        responseData = await uploadFile(path, file, data: data, enableRefreshToken: false, headers: headers);
      }
    }

    return responseData;
  }
}