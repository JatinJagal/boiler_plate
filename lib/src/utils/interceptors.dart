import 'dart:io';

import 'package:boiler_plate/src/services/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    /// Put the paths you want the interceptor to ignore

    final token = await LocalStorageService.i.getStorageValue("token");
    if (!options.path.contains('/login') ||
        !options.path.contains('/register')) {
      /// Fetch your token from local storage (or wherever) and plug it in
      // var token = '<YOUR-TOKEN-HERE>';
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    handler.next(options);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.cancel:
        err = err.copyWith(error: 'Request to API server was cancelled');
        break;
      case DioExceptionType.connectionTimeout:
        err = err.copyWith(error: 'Connection to API server timed out');
        break;
      case DioExceptionType.receiveTimeout:
        err = err.copyWith(
            error: 'Receive timeout in connection with API server');
        break;
      case DioExceptionType.sendTimeout:
        err = err.copyWith(error: 'Send timeout in connection with API server');
        break;
      case DioExceptionType.badResponse:
        if (err.response!.data != null) {
          if (err.response!.data is String) {
            err = err.copyWith(
                error: '${err.response!.statusCode}: ${err.response!.data}');
          } else {
            err = err.copyWith(error: err.response!.data['message']);
          }
          if (err.response!.statusCode == 404 && err.response!.data is String) {
            err = err.copyWith(
                error: '${err.response!.statusCode} Page not found.');
          }
          if (err.response!.statusCode == 500 && err.response!.data is String) {
            err = err.copyWith(
                error: '${err.response!.statusCode} Internal server error.');
          }

          if (err.response!.statusCode == 401) {
            err = err.copyWith(error: 'Unauthenticated');
          }
          if (err.response!.statusCode == 403) {
            err = err.copyWith(error: 'Unauthorized');
          }
        } else {
          err = err.copyWith(
              error:
                  'Received invalid status code: ${err.response!.statusCode}');
        }
        break;

      case DioExceptionType.unknown:
        err = err.copyWith(
            error:
                'Connection to API server failed due to internet connection');
        break;
      case DioExceptionType.badCertificate:
        err = err.copyWith(error: 'Bad Certificate!');
        break;
      case DioExceptionType.connectionError:
        err = err.copyWith(error: 'Connection Error');
        break;
    }
    handler.next(err);
  }
}

class UserAgentInterceptor extends Interceptor {
  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var packageInfo = await PackageInfo.fromPlatform();
    options.headers['User-Agent'] =
        '${packageInfo.appName} - ${packageInfo.packageName}/${packageInfo.version}+${packageInfo.buildNumber} - Dart/${Platform.version} - OS: ${Platform.operatingSystem}/${Platform.operatingSystemVersion}';
    handler.next(options);
  }
}
