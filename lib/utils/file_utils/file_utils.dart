import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ahmoma_app/utils/constants/constants.dart';
import 'package:ahmoma_app/utils/extensions/context_extension.dart';
import 'package:ahmoma_app/utils/logging/app_logging.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FileUtils {
  static Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.status;
    if (status.isDenied || status.isRestricted) {
      final result = await permission.request();
      return result.isGranted;
    }
    return status.isGranted;
  }

  static Future<List<File>?> handlePickImage(
      BuildContext context, {
        required ImagePicker picker,
        bool isUsingCamera = false,
        bool isMultiImage = false,
        int imageQuality = 50,
      }) async {
    Permission permissionType = isUsingCamera ? Permission.camera : Permission.photos;

    PermissionStatus status = await permissionType.status;

    if (status.isDenied || status.isRestricted || status.isLimited) {
      bool isGranted = await _requestPermission(permissionType);
      if (isGranted && context.mounted) {
        return await _pickImage(context, picker, isUsingCamera, isMultiImage, imageQuality);
      } else {
        return null;
      }
    } else if (status.isGranted && context.mounted) {
      return await _pickImage(context, picker, isUsingCamera, isMultiImage, imageQuality);
    } else if (status.isPermanentlyDenied && context.mounted) {
      await context.showAlertDialog(
        title: "Notification",
        content: isUsingCamera
            ? 'Food Order needs camera access to take a photo of your menu or avatar'
            : 'Food Order requires access to your photo library to upload your photos',
        onOk: () {
          openAppSettings();
        },
      );
      return null;
    }

    return null;
  }

  static Future<List<File>?> _pickImage(
      BuildContext context,
      ImagePicker picker,
      bool isUsingCamera,
      bool isMultiImage,
      int imageQuality,
      ) async {
    List<File> files = [];
    try {
      List<XFile>? xFiles;
      if (isUsingCamera) {
        final image = await picker.pickImage(
            source: ImageSource.camera, imageQuality: imageQuality);
        if (image != null) xFiles = [image];
      } else {
        if (isMultiImage) {
          xFiles = await picker.pickMultiImage(imageQuality: imageQuality);
        } else {
          final image = await picker.pickImage(
              source: ImageSource.gallery, imageQuality: imageQuality);
          if (image != null) xFiles = [image];
        }
      }
      if (xFiles != null) {
        for (var xFile in xFiles) {
          if (!AppConstants.allowPhotoExtensions.contains(xFile.path.split('.').last.toLowerCase()) && context.mounted) {
            context.showError('Only PNG/JPG is accepted');

            continue;
          }
          int length = await xFile.length();
          if (length > 1024 * 1024 * 50 && context.mounted) {
            context.showError('File must not exceed 50MB');

            continue;
          }
          files.add(File(xFile.path));
        }
      }
    } catch (e) {
      if(context.mounted) {
        context.showError('An error occurred while selecting the file!');
      }
    }

    return files;
  }

  // static Future<String?> downloadAndSaveFile(String url, String fileName) async {
  //   try {
  //     final Directory directory = await getApplicationDocumentsDirectory();
  //     final String filePath = '${directory.path}/$fileName';
  //     final Response response = await Dio().get(url,options: Options(responseType: ResponseType.bytes));
  //     final File file = File(filePath);
  //     await file.writeAsBytes(response.data);
  //
  //     return filePath;
  //   } catch (e) {
  //     AppLogger.error("downloadAndSaveFile exception $e");
  //   }
  //   return null;
  // }
}