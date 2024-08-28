import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../base_http_client.dart';
import '../http_request_endpoint.dart';
import '../http_result.dart';

class HttpClient extends BaseHttpClient {
  HttpClient() : super();

  final http.Client _httpClient = http.Client();

  @override
  Future<HttpResult> createRequest(HttpRequestEndpoint request) async {
    final http.BaseRequest httpRequest = _transformRequestEndpoint(request);

    try {
      final httpSendRequest = await _httpClient.send(httpRequest).timeout(timeout);
      final response = await http.Response.fromStream(httpSendRequest);

      dynamic data;

      // JSON
      // data = json.decode(utf8.decode(response.bodyBytes));
      data = json.decode(response.body);

      // bytes
      data ??= response.bodyBytes;

      if (isSuccessRequest(response.statusCode)) {
        return HttpResult.success(
          statusCode: response.statusCode,
          headers: response.headers,
          data: data,
          originalRequest: request,
        );
      } else {
        return HttpResult.failure(
          originalRequest: request,
          error: data,
          statusCode: response.statusCode,
          headers: response.headers,
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

  http.Request _transformRequestEndpoint(HttpRequestEndpoint request) {
    final uri = Uri.parse(request.path);
    if (request.queryParameters?.isNotEmpty == true) {
      uri.replace(queryParameters: request.queryParameters).toString();
    }

    final httpRequest = http.Request(request.method.value, uri)..headers.addAll(_asMap(request.headers ?? {}));
    if (request.data?.isNotEmpty == true) {
      httpRequest.body = jsonEncode(request.data);
    }

    return httpRequest;
  }

  Map<String, String> _asMap(Map<String, dynamic> headers) {
    final Map<String, String> newMap = {};
    if (headers.isEmpty) return newMap;

    headers.forEach((key, value) {
      if (value is String) {
        newMap[key] = value;
      } else if (value is List<String>) {
        newMap[key] = value.join(',');
      }
    });

    return newMap;
  }
}
