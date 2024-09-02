import '../../../../base/abstractions/custom_exception.interface.dart';
import '../../../../base/dal/data/error.data.dart';

class InvalidEmailException implements CustomException {
  @override
  final ErrorData failure;

  InvalidEmailException(this.failure);

  @override
  String toString() => failure.message;
}
