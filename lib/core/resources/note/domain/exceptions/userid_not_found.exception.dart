import '../../../../base/abstractions/custom_exception_interface.dart';
import '../../../../base/dal/data/error_data.dart';

class UseridNotFoundException implements CustomException {
  final ErrorData _failure;

  @override
  ErrorData get failure => _failure;

  UseridNotFoundException({required ErrorData failure}) : _failure = failure;
}
