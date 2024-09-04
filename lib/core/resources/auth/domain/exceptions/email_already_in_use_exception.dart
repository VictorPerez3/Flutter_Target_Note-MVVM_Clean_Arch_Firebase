import '../../../../base/abstractions/custom_exception_interface.dart';
import '../../../../base/dal/data/error_data.dart';

class EmailAlreadyInUseException implements CustomException {
  @override
  final ErrorData failure;

  EmailAlreadyInUseException(this.failure);

  @override
  String toString() => failure.message;
}
