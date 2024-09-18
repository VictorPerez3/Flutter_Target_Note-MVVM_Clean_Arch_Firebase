import '../dal/data/error_data.dart';

abstract class CustomException implements Exception {
  ErrorData get failure;
}