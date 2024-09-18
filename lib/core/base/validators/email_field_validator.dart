import 'package:equatable/equatable.dart';

import '../../i18n/translation.dart';
import '../abstractions/validators/field_validator_interface.dart';
import '../injection/inject.dart';

class EmailFieldValidator<T> extends Equatable
    implements IFieldValidator<T> {
  final i18n = Inject.find<StringsTranslations>().strings.validators;

  @override
  String? validate(T? value) {
    final messageInvalidEmail = i18n.invalidEmail;
    if (value is String && value.length < 6) {
      return messageInvalidEmail;
    }
    return null;
  }

  @override
  List<Object?> get props => [];
}
