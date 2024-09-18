import '../../../../base/abstractions/custom_exception_interface.dart';
import '../../../../base/dal/data/error_data.dart';

class NetworkRequestFailedException implements CustomException {
  @override
  final ErrorData failure;

  NetworkRequestFailedException(this.failure);

  @override
  String toString() => failure.message;
}
