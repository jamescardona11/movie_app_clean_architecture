import 'package:movie_app_clean_architecture/core/errors/app_error.dart';
import 'package:movie_app_clean_architecture/core/errors/app_remote_error.dart';

import 'base_http_client.dart';
import 'http_request_endpoint.dart';

class HttpResult {
  // Request info.
  final HttpRequestEndpoint originalRequest;

  // Error
  final AppError? appError;

  // Response
  final dynamic data;
  final int? statusCode;
  final Map<String, dynamic>? headers;

  HttpResult._({
    required this.originalRequest,
    this.data,
    this.headers,
    this.statusCode,
    this.appError,
  });

  factory HttpResult.success({
    required dynamic data,
    required Map<String, dynamic> headers,
    required HttpRequestEndpoint originalRequest,
    int? statusCode,
  }) =>
      HttpResult._(
        headers: headers,
        data: data,
        originalRequest: originalRequest,
        statusCode: statusCode,
      );

  factory HttpResult.failure({
    required dynamic error,
    required HttpRequestEndpoint originalRequest,
    Map<String, dynamic> headers = const {},
    int? statusCode,
    StackTrace? stackTrace,
  }) =>
      HttpResult._(
        headers: headers,
        originalRequest: originalRequest,
        statusCode: statusCode,
        appError: AppRemoteError.fromError(error, stackTrace, statusCode),
      );

  /// Returns true if [Result] is [Failure].
  bool get isFailure => appError != null || !isSuccess;

  /// Returns true if [Result] is [Success].
  bool get isSuccess => isSuccessRequest(statusCode);

  Map<String, dynamic>? get dataJson => data is Map<String, dynamic> ? data as Map<String, dynamic> : null;

  List<int>? get dataBytes => data is List<int> ? data as List<int> : null;

  String? get dataString => data is String ? data as String : null;

  String get errorMessage {
    return appError?.error is List<int> ? String.fromCharCodes(appError!.error) : (appError.toString());
  }

  @override
  String toString() {
    if (isSuccess) {
      return 'SuccessResult(\nstatusCode: $statusCode, data: $data, headers: ${headers.toString()}\n)';
    }

    return 'FailureResult \nstatusCode: $statusCode, \nError: ${appError?.toString()}';
  }
}
