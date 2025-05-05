class ApiKeyParam {
  static String error = "error";
  static String data = "data";
  static String pagination = "meta";
  static String message = "message";
  static String code = "code";
  static String total = "totalItem";
  static String limit = "pageSize";
  static String offset = "offset";
  static String page = "page";
}

abstract class IResponse {
  IResponse();

  IResponse.fromMap(Map<dynamic, dynamic> json);

  IResponse.withError(int errorCode, String message);
}

class DefaultResponse<T> extends IResponse {
  T? data;
  DefaultError? error;

  DefaultResponse({
    this.data,
    this.error,
  });

  DefaultResponse.fromMap(Map<dynamic, dynamic> json) {
    if (json[ApiKeyParam.error] != null) {
      error = DefaultError.fromJson(json[ApiKeyParam.error]);
    }

    if (json[ApiKeyParam.data] != null) {
      data = json[ApiKeyParam.data] as T;
    }
  }

  DefaultResponse.withError(DefaultError err) {
    data = null;
    error = err;
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'error': error?.toJson(),
    };
  }
}

class PaginationResponse<T> extends IResponse {
  late List<T>? data;
  DefaultError? error;
  Pagination? pagination;

  PaginationResponse({
    this.data,
    this.error,
    this.pagination,
  });

  PaginationResponse.fromMap(Map<dynamic, dynamic> json) {
    if (json[ApiKeyParam.error] != null) {
      error = DefaultError.fromJson(json[ApiKeyParam.error]);
    } else {
      data = json[ApiKeyParam.data] ?? [];
      pagination = json[ApiKeyParam.pagination] != null
          ? Pagination.fromJson(json[ApiKeyParam.pagination])
          : null;
    }
  }

  PaginationResponse.withError(DefaultError err) {
    data = null;
    error = err;
  }
}

class Pagination {
  int total = 0;
  int offset = 0;
  int page = 0;
  int limit = 0;

  Pagination({
    this.total = 0,
    this.offset = 0,
    this.limit = 0,
    this.page = 0,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json[ApiKeyParam.total] ?? 0;
    offset = json[ApiKeyParam.offset] ?? 0;
    page = json[ApiKeyParam.page] ?? 0;
    limit = json[ApiKeyParam.limit] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeyParam.total: total,
      ApiKeyParam.offset: offset,
      ApiKeyParam.limit: limit
    };
  }
}

class DefaultError {
  String message = "Có lỗi xảy ra";
  int code = 0;

  DefaultError({
    this.message = 'Có lỗi xảy ra',
    this.code = 0,
  });

  DefaultError.fromJson(Map<String, dynamic> json) {
    message = json[ApiKeyParam.message]?.toString() ?? '';
    code = json[ApiKeyParam.code] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeyParam.message: message,
      ApiKeyParam.code: code,
    };
  }
}
