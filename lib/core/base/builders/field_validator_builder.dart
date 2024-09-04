import '../abstractions/validators/field_validator_interface.dart';
import '../validators/password_field_validator.dart';
import '../validators/required_field_validator.dart';
import '../validators/username_field_validator.dart';

class FieldValidatorBuilder<T> {
  final List<IFieldValidator<T>> _validators = [];

  FieldValidatorBuilder<T> required() {
    _validators.add(RequiredFieldValidator<T>());
    return this;
  }

  FieldValidatorBuilder<T> password() {
    _validators.add(PasswordFieldValidator<T>());
    return this;
  }

  FieldValidatorBuilder<T> username() {
    _validators.add(UsernameFieldValidator<T>());
    return this;
  }

  List<IFieldValidator<T>> build() => _validators;
}
