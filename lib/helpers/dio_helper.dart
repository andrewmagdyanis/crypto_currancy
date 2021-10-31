import 'package:dio/dio.dart';

import '../constants.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        sendTimeout: 6000,
        receiveTimeout: 12000,
        connectTimeout: 6000,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response<dynamic>> getData(
      String url, Map<String, dynamic> query) {
    return dio.get(url,
        queryParameters: query, options: Options(method: 'GET'));
  }
}

class DioExceptions implements Exception {
  DioExceptions.fromDioError(dynamic dioError) {
    if (dioError.runtimeType == DioErrorType) {
      switch (dioError) {
        case DioErrorType.cancel:
          message = "Request to API server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          message = "Connection timeout with API server";
          break;
        case DioErrorType.other:
          message =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.receiveTimeout:
          message = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          message = _handleError(
              dioError.response!.statusCode!, dioError.response!.data);
          break;
        case DioErrorType.sendTimeout:
          message = "Send timeout in connection with API server";
          break;
        default:
          message = "Something went wrong";
          break;
      }
    } else {
      message = "Some parameters not found";
      print(message);

    }
  }

  late String message;

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return error["message"];
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
