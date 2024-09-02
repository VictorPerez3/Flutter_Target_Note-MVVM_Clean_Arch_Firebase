import 'package:equatable/equatable.dart';

import '../../i18n/translation.dart';
import '../abstractions/validators/field_validator.interface.dart';
import '../injection/inject.dart';

class RequiredFieldValidator<T> extends Equatable
    implements IFieldValidator<T> {
  final i18n = Inject.find<StringsTranslations>().strings.validators;

  @override
  String? validate(T? value) {
    final message = i18n.required;
    if (value == null || (value is String && value.isEmpty)) {
      return message;
    }
    return null;
  }

  @override
  List<Object?> get props => [];
}
