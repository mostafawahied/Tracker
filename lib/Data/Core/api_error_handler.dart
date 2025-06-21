import '../../Index/index.dart';

class ErrorHandler {
  /// Handles any type of error and returns an `ApiErrorModel`
  static ApiErrorModel handle(
    dynamic error, {
    bool? fromResponse,
    int? statusCode,
  }) {
    if (error is TimeoutException) {
      return ApiErrorModel(
        message: "Request timed out. Please try again.",
        code: 408, // Common HTTP status code for timeout
      );
    } else if (error is SocketException) {
      return ApiErrorModel(
        message: "No Internet connection. Please check your connection.",
        code: 503, // Service Unavailable
      );
    } else if (error is HttpException) {
      return ApiErrorModel(
        message: "HTTP request failed. Please try again.",
        code: 500,
      );
    } else if (error is FormatException) {
      return ApiErrorModel(
        message: "Invalid response format. Please try again.",
        code: 400,
      );
    } else if (fromResponse == true) {
      return handleHttpResponseError(error, statusCode ?? 0);
    } else {
      return ApiErrorModel(
        message: error.toString(),
        code: null, // Undefined error code
      );
    }
  }

  static ApiErrorModel handleHttpResponseError(
    dynamic response,
    int statusCode,
  ) {
    try {
      final data = json.decode(response.body);

      // Check for specific status codes
      if (statusCode == 401) {
        return ApiErrorModel(
          message:
              "Session expired or unauthorized access. Please log in again.",
          code: 401,
        );
      }

      return ApiErrorModel.fromDynamic(data, statusCode: statusCode);
    } catch (e) {
      return ApiErrorModel(
        message: "An unexpected error occurred. Please try again.",
        code: statusCode,
      );
    }
  }
}
