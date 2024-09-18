import '../../../../base/abstractions/custom_exception_interface.dart';
import '../../../../base/dal/data/error_data.dart';

class InvalidEmailException implements CustomException {
  @override
  final ErrorData failure;

  InvalidEmailException(this.failure);

  @override
  String toString() => failure.message;
}
