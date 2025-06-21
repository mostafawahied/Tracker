import '../../Index/index.dart';

class ApiErrorModel {
  final String message;
  final int? code;

  ApiErrorModel({required this.message, this.code});

  /// Factory method to handle dynamic response and return an appropriate ApiErrorModel
  factory ApiErrorModel.fromDynamic(dynamic response, {int? statusCode}) {
    if (kDebugMode) {
      print("response innn api is $response");
    }

    if (response is String) {
      return ApiErrorModel(message: response, code: statusCode);
    } else if (response is Map<String, dynamic>) {
      final hasMessage =
          response.containsKey('message') && response['message'] is String;
      final hasErrors = response.containsKey('errors');

      if (hasErrors) {
        final errors = response['errors'];

        if (errors is Map<String, dynamic> && errors.isNotEmpty) {
          final buffer = StringBuffer();
          errors.forEach((key, value) {
            if (value is List) {
              buffer.writeln(value.join(', '));
            } else {
              buffer.writeln(value.toString());
            }
          });
          return ApiErrorModel(
            message: buffer.toString().trim(),
            code: statusCode,
          );
        }
      }

      // Show fallback message if errors are empty or null
      if (hasMessage) {
        return ApiErrorModel(message: response['message'], code: statusCode);
      }
    }

    return ApiErrorModel(
      message: "Unexpected response format",
      code: statusCode,
    );
  }

  @override
  String toString() {
    return message;
  }
}
