import 'dart:developer';

import 'package:boiler_plate/src/common/global.dart';
import 'package:boiler_plate/src/utils/interceptors.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

class ApiService {
  final Dio _dio = Dio();

  // String get serverUrl => dotenv
  //     .env['SERVER_URL']!; //!isTestServer ? 'SERVER_URL' : 'TEST_SERVER_URL'
  ApiService() {
    _dio.options.baseUrl = serverUrl;
    _dio.options.headers = {
      "accept": "application/json",
      "Content-Type": "application/json"
    };
    _dio.interceptors.addAll([
      /// It is used to catch error while requesting to server.
      ErrorInterceptor(),

      /// It is used to add an authenticate while request an api.
      AuthInterceptor(),

      /// It is used to send information related to user(OS Version, App version) etc.
      UserAgentInterceptor()
    ]);
    if (kDebugMode) {
      _dio.interceptors.add(
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printResponseHeaders: true,
            printResponseMessage: true,
            printResponseData: true,
            printRequestData: true,
          ),
        ),
      );
    }
  }

  String get serverUrl =>
      dotenv.env[!isTestServer ? 'SERVER_URL' : 'TEST_SERVER_URL']!;

  Future<Either<String, Response<dynamic>?>> get(
    //Either<String, Response>
    String path, {
    Map<String, String>? headers,
    CancelToken? cancelToken,
    Options? options,
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      /*  final res = await _dio.get(path,
          queryParameters: queryParameter,
          cancelToken: cancelToken,
          options: options);
      return Right(res);*/
      //--right method
      /*return _dio.get(path,
          queryParameters: queryParameter,
          cancelToken: cancelToken,
          options: options);*/
      //--for test
      final res = await _dio.get(path,
          queryParameters: queryParameter,
          cancelToken: cancelToken,
          options: options);
      return Right(res);
    } on DioException catch (e) {
      //only catch
      // return null;
      return Left(e.error.toString());
    }
  }

  Future<Either<String, Response>> post(
    String path,
    dynamic data, {
    CancelToken? cancelToken,
    Options? options,
  }) async {
//for using token
/*final token = await LocalStorageService.i.getStorageValue("token");
      // print("ufbisbufr-> $token");

      _dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';*/
//

    try {
      final res = await _dio.post(
        path,
        data: data,
      );

      print(res);
      return Right(res);
    } on DioException catch (e) {
      log("Method: ApiService->post()");
      // log("Error: ${e.error.toString()}");
      // return Left(e.error.toString());

      log("Error: ${e.error.toString()}");
      return Left(e.response.toString());
    }
  }

  //
  Future<Response<dynamic>?> delete(
    String path, {
    Map<String, String>? headers,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      return _dio.delete(
        path,
        cancelToken: cancelToken,
        options: options,
      );
    } on DioException catch (e) {
      log("Method: ApiService->delete()");
      log("Error: ${e.message}");
      return null;
    }
  }

  Future<Response<dynamic>?> put(
    String path,
    dynamic data, {
    Map<String, String>? headers,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      return _dio.put(
        path,
        data: data,
        cancelToken: cancelToken,
        options: options,
      );
    } on DioException catch (e) {
      log("Method: ApiService->put()");
      log("Error: ${e.message}");
      return null;
    }
  }
}
