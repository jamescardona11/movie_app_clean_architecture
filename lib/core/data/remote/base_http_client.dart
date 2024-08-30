import 'http_request_endpoint.dart';
import 'http_result.dart';

abstract class BaseHttpClient {
  Future<HttpResult> createRequest(HttpRequestEndpoint request);

  Duration get timeout => const Duration(milliseconds: 4000);
}

bool isSuccessRequest(int? statusCode) =>
    statusCode != null &&
    ![
      100, // Custom code
      400, // Bad Request
      401, // Unauthorized
      402, // Payment Required
      403, // Forbidden
      404, // Not Found
      405, // Method Not Allowed,
      413, // Request Entity Too Large
      414, // Request URI Too Long,
      415, // Unsupported Media Type
    ].contains(statusCode);
