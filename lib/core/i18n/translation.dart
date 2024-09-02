import 'contexts/auth_error.strings.dart';
import 'contexts/auth_screen.strings.dart';
import 'contexts/general.strings.dart';
import 'contexts/note_error.strings.dart';
import 'contexts/note_screen.strings.dart';
import 'contexts/validators.strings.dart';

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
