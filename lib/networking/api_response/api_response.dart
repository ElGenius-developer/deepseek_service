import 'package:freezed_annotation/freezed_annotation.dart';

import '../api_error/api_error_handler.dart';

part 'api_response.freezed.dart';

@freezed
abstract class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.success(T data) = Success<T>;
  const factory ApiResponse.failure(ErrorHandler errorHandler) = Failure<T>;
}
