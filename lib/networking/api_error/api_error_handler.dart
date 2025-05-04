// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:deepseek_service/networking/api_error/api_error.dart';
import 'api_error_model.dart';
export 'package:dio/dio.dart';
export 'api_error_model.dart';
export 'api_error.dart';

class ErrorHandler implements Exception {
  late ApiErrorModel apiErrorModel;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      apiErrorModel = _handleError(error);
    } else if (error is ApiErrors) {
      apiErrorModel = error.model;
    } else {
      apiErrorModel = ApiErrors.defaultError.model;
    }
  }

  ApiErrorModel _handleError(DioException error) {
    final errorMap = <DioExceptionType, ApiErrorModel>{
      DioExceptionType.connectionTimeout: ApiErrors.timeoutError.model,
      DioExceptionType.sendTimeout: ApiErrors.sendTimeoutError.model,
      DioExceptionType.receiveTimeout: ApiErrors.timeoutError.model,
      DioExceptionType.cancel: ApiErrors.cancleError.model,
      DioExceptionType.connectionError: ApiErrors.noInternetConnection.model,
      DioExceptionType.badCertificate: ApiErrors.defaultError.model,
      DioExceptionType.badResponse: ApiErrors.badRequestError.model,
      DioExceptionType.unknown: ApiErrors.defaultError.model,
    };

    return errorMap[error.type] ?? ApiErrors.defaultError.model;
  }
}
