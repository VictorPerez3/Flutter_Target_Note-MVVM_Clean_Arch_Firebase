import 'package:equatable/equatable.dart';

import '../../i18n/translation.dart';
import '../abstractions/validators/field_validator.interface.dart';
import '../injection/inject.dart';

class PasswordFieldValidator<T> extends Equatable
    implements IFieldValidator<T> {
  final i18n = Inject.find<StringsTranslations>().strings.validators;

  @override
  String? validate(T? value) {
    final messageInvalidPassword = i18n.invalidPassword;
    if (value is String && value.length < 6) {
      return messageInvalidPassword;
    }
    return null;
  }

  @override
  List<Object?> get props => [];
}
