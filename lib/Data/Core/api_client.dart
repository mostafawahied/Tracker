// ignore_for_file: constant_identifier_names

import 'package:http/http.dart' as http;

import '../../Index/index.dart';

typedef HttpRequestFunction =
    Future<http.Response> Function(
      Uri uri, {
      Map<String, String>? headers,
      Object? body,
    });

Future<http.Response> getRequest(
  Uri uri, {
  Map<String, String>? headers,
  Object? body,
}) {
  return http.get(uri, headers: headers); // Body is ignored for GET
}

enum HttpMethod {
  GET(getRequest),
  POST(_postRequest),
  PATCH(_postRequest),
  PUT(_postRequest),
  DELETE(http.delete);

  final dynamic method;

  const HttpMethod(this.method);
}

Future<http.Response> _postRequest(
  Uri uri, {
  Map<String, String>? headers,
  Object? body,
}) async {
  final request = http.MultipartRequest('POST', uri);

  if (headers != null) {
    request.headers.addAll(headers);
  }

  final streamedResponse = await request.send();
  return http.Response.fromStream(streamedResponse);
}

class ClientSourceRepo {
  static const int timeoutDuration = 10;

  Future<dynamic> request(
    HttpMethod method,
    String path, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    Map<String, String>? files,
  }) async {
    final uri = _buildUri(path, params, method);
    headers = headers ?? defaultHeaders();

    try {
      if (files != null && files.isNotEmpty) {
        return await _sendMultipartRequest(
          method: method,
          uri: uri,
          params: params,
          headers: headers,
          files: files,
        );
      } else {
        return await _sendDefaultRequest(
          method,
          uri,
          params: params,
          headers: headers,
        );
      }
    } catch (e) {
      final exception = ErrorHandler.handle(e);
      if (kDebugMode) {
        print("❌ Exception thrown: ${exception.message}");
      }
      throw exception;
    }
  }

  Future<dynamic> _sendDefaultRequest(
    HttpMethod method,
    Uri uri, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
  }) async {
    try {
      if (kDebugMode) {
        print("📤 Sending ${method.name} request to $uri");
        print("📦 Request Headers: $headers");
        print("📦 Request Params: ${params ?? 'No Params'}");
      }

      final response = await method
          .method(
            uri,
            headers: headers,
            body: (method == HttpMethod.GET || method == HttpMethod.DELETE)
                ? null
                : params,
          )
          .timeout(const Duration(seconds: timeoutDuration));

      return _processResponse(response);
    } catch (e) {
      final exception = ErrorHandler.handle(e);
      if (kDebugMode) {
        print("❌ Exception in _sendDefaultRequest: ${exception.message}");
      }
      throw exception;
    }
  }

  Future<dynamic> _sendMultipartRequest({
    required HttpMethod method,
    required Uri uri,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    required Map<String, String> files,
  }) async {
    final request = http.MultipartRequest(method.name, uri);

    if (headers != null) {
      request.headers.addAll(headers);
    }

    if (kDebugMode) {
      print("📤 Multipart Request to $uri");
      print("📦 Headers: $headers");
      print("📦 Params: $params");
      print("📦 Files: $files");
    }

    if (params != null) {
      params.forEach((key, value) {
        request.fields[key] = value.toString();
      });
    }

    for (final entry in files.entries) {
      final filePath = entry.value;
      final file = File(filePath);
      if (file.existsSync()) {
        request.files.add(
          await http.MultipartFile.fromPath(entry.key, filePath),
        );
      } else {
        throw Exception("File not found: $filePath");
      }
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (kDebugMode) {
      print("📥 Multipart Status Code: ${response.statusCode}");
      print("📥 Multipart Body: ${response.body}");
    }

    return _processResponse(response);
  }

  Uri _buildUri(String path, Map<String, dynamic>? params, HttpMethod method) {
    const baseUrl = ApiConstants.Base_Url;

    if (method == HttpMethod.GET || method == HttpMethod.DELETE) {
      if (params == null || params.isEmpty) {
        return Uri.parse('$baseUrl$path');
      } else {
        final query = params.entries
            .map((e) => Uri.encodeComponent(e.value.toString()))
            .join('/');
        return Uri.parse('$baseUrl$path/$query');
      }
    } else {
      return Uri.parse('$baseUrl$path');
    }
  }

  Map<String, String> defaultHeaders({String? tokenKey}) {
    final Map<String, String> headers = {'Accept': 'application/json'};

    return headers;
  }

  dynamic _processResponse(http.Response response) {
    if (kDebugMode) {
      print('📥 Status Code: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        if (kDebugMode) {
          print("❌ JSON parsing failed: $e");
        }
        throw ApiErrorModel(
          message: "Failed to parse response",
          code: response.statusCode,
        );
      }
    } else {
      if (kDebugMode) {
        print('❌ Error Response: ${response.body}');
      }
      throw ErrorHandler.handle(
        response,
        fromResponse: true,
        statusCode: response.statusCode,
      );
    }
  }
}
