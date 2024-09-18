import '../../../../base/abstractions/custom_exception_interface.dart';
import '../../../../base/dal/data/error_data.dart';

class OtherAuthException implements CustomException {
  @override
  final ErrorData failure;

  OtherAuthException(this.failure);

  @override
  String toString() => failure.message;
}
