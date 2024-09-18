import 'contexts/auth_error_strings.dart';
import 'contexts/auth_screen_strings.dart';
import 'contexts/general_strings.dart';
import 'contexts/note_error_strings.dart';
import 'contexts/note_screen_strings.dart';
import 'contexts/validators_strings.dart';

class StringsI18n {
  final AuthScreenStrings loginPage;
  final NoteScreenStrings notePage;
  final GeneralStrings general;
  final ValidatorsStrings validators;
  final AuthErrorStrings authError;
  final NoteErrorStrings noteError;

  StringsI18n(
      {required this.loginPage,
      required this.notePage,
      required this.general,
      required this.validators,
      required this.authError,
      required this.noteError});
}

abstract class StringsTranslations {
  StringsI18n get strings;
}
