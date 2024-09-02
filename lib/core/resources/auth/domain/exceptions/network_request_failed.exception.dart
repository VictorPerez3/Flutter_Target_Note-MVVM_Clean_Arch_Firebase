import '../../../../base/abstractions/custom_exception.interface.dart';
import '../../../../base/dal/data/error.data.dart';

class NetworkRequestFailedException implements CustomException {
  @override
  final ErrorData failure;

  NetworkRequestFailedException(this.failure);

  @override
  String toString() => failure.message;
}
