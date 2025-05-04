import 'package:deepseek_service/networking/api_error/api_error_model.dart';

enum ApiErrors {
  badRequestError(ApiErrorModel(message: "Bad Request", code: 400)),
  success(ApiErrorModel(message: "Success", code: 200)),
  badResponseError(ApiErrorModel(message: "Bad Response", code: 422)),
  noContent(ApiErrorModel(message: "No Content", code: 201)),
  forbiddenError(ApiErrorModel(message: "Forbidden", code: 403)),
  unauthorizedError(ApiErrorModel(message: "Unauthorized", code: 401)),
  notFoundError(ApiErrorModel(message: "Not Found", code: 404)),
  conflictError(ApiErrorModel(message: "Conflict", code: 409)),
  internalServerError(ApiErrorModel(message: "Internal Server Error", code: 500)),
  unknownError(ApiErrorModel(message: "Unknown Error", code: 0)),
  sendTimeoutError(ApiErrorModel(message: "Send Timeout Error", code: -4)),
  timeoutError(ApiErrorModel(message: "Timeout Error", code: -1)),
  defaultError(ApiErrorModel(message: "Something went wrong", code: -7)),
  cacheError(ApiErrorModel(message: "Cache Error", code: -5)),
  noInternetConnection(ApiErrorModel(message: "No Internet Connection", code: -6)),
  cancleError(ApiErrorModel(message: "Request Cancelled", code: -2)),
  retryAgainMessage(ApiErrorModel(message: "Please try again", code: -8)),
  ok(ApiErrorModel(message: "Ok", code: 200));

  final ApiErrorModel model;

  const ApiErrors(this.model);

  //get api error by code
  static ApiErrors getApiErrorByCode(int code) {
    try {
      return ApiErrors.values.firstWhere((element) => element.model.code == code);
    } catch (e) {
      return ApiErrors.unknownError;
    }
  }
}
