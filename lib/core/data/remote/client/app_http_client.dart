import 'dart:async';

import 'package:dio/dio.dart';
import 'package:movie_app_clean_architecture/core/logger/logger.dart';

import '../base_http_client.dart';
import '../http_request_endpoint.dart';
import '../http_result.dart';

class AppHttpClient extends BaseHttpClient {
  AppHttpClient(this.dio, this.bearerToken) : super();

  final Dio dio;
  final String bearerToken;

  @override
  Future<HttpResult> createRequest(HttpRequestEndpoint request) async {
    try {
      final headers = request.headers ?? {};
      headers['Authorization'] = 'Bearer $bearerToken';
      final response = await dio
          .get(
            request.path,
            queryParameters: request.queryParameters,
            options: Options(
              headers: headers,
            ),
          )
          .timeout(timeout);

      if (isSuccessRequest(response.statusCode)) {
        // AppLogger().s('Success request $data');
        return HttpResult.success(
          statusCode: response.statusCode,
          data: response.data,
          originalRequest: request,
        );
      } else {
        AppLogger().e('Error request ${response.data}');
        return HttpResult.failure(
          originalRequest: request,
          error: response.data,
          statusCode: response.statusCode,
        );
      }
    } catch (err, stackTrace) {
      return HttpResult.failure(
        originalRequest: request,
        error: err,
        stackTrace: stackTrace,
        statusCode: 100, //custom code
      );
    }
  }
}
