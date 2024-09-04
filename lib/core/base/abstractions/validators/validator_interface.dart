import 'field_validator_interface.dart';

abstract class IValidator<T> {
  final List<IFieldValidator<T>> validators;

  IValidator({required this.validators});

  bool get hasError;

  bool validate();

  String? validateValue(T? value) {
    for (final validator in validators) {
      final error = validator.validate(value);
      if (error != null) {
        return error;
      }
    }

    return null;
  }
}
