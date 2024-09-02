import '../../../../base/abstractions/custom_exception.interface.dart';
import '../../../../base/dal/data/error.data.dart';

class OtherAuthException implements CustomException {
  @override
  final ErrorData failure;

  OtherAuthException(this.failure);

  @override
  String toString() => failure.message;
}
