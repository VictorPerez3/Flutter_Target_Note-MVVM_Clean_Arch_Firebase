import '../../../../base/abstractions/custom_exception.interface.dart';
import '../../../../base/dal/data/error.data.dart';

class EmailAlreadyInUseException implements CustomException {
  @override
  final ErrorData failure;

  EmailAlreadyInUseException(this.failure);

  @override
  String toString() => failure.message;
}
