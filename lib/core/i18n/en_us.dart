import 'contexts/auth_error_strings.dart';
import 'contexts/auth_screen_strings.dart';
import 'contexts/general_strings.dart';
import 'contexts/note_error_strings.dart';
import 'contexts/note_screen_strings.dart';
import 'contexts/validators_strings.dart';
import 'translation.dart';

class EnUsStringsTranslations implements StringsTranslations {
  static const String getLocale = 'en-US';

  final loginPage = AuthScreenStrings(
    completeNameLabel: 'Name',
    passwordLabel: 'Password',
    repeatPasswordLabel: 'Repeat Password',
    signInButtonLabel: 'Sign In',
    signUpButtonLabel: 'Sign Up',
    signInTextLabel: "Already don't have an Account ?",
    signUpTextLabel: "Already have an Account ?",
    addUserToast: 'New User Created',
  );

  final notePage = NoteScreenStrings(
      removeItemToast: 'Note removed',
      addItemToast: 'Note added',
      editItemToast: 'Note edited',
      newRegisterButton: 'New Register',
      textLabelModal: 'Note Details',
      titleLabelModal: 'Title',
      noteTextLabelModal: 'Note Text',
      saveButton: 'Save',
      cancelButton: 'Cancel',
      notesButtonSegment: 'Notes',
      bankNotesButtonSegment: 'Bank\nNotes',
      personalAccountsButtonSegment: 'Personal\nAccounts');

  final general = GeneralStrings(
    sucessToast: 'Sucess!',
    privacyPolicyLabel: 'Privacy Policy',
  );

  final validators = ValidatorsStrings(
    invalidEmail: 'E-mail is invalid',
    requiredEmail: 'E-mail is required',
    invalidPassword: 'Password invalid: At least 6 characters',
    requiredPassword: 'Password is required',
    required: 'Field is required',
  );

  final authError = AuthErrorStrings(
      credentialsMessage: 'Invalid e-mail or password',
      otherErrorMessage: 'An unknown error has occurred',
      emailAlreadyInUseMessage: 'Email already registered',
      invalidEmailMessage: 'Invalid Email',
      networkRequestFailedMessage: 'Network Request Failed',
      passwordsDoNotMatchMessage: 'Passwords Do Not Match');

  final noteError = NoteErrorStrings(
      useridNotFoundMessage: 'User ID not found in storage',
      noteIdNotFoundMessage: 'Note Id not found',
      deleteNoteFailMessage: 'Note delete failed: Note Id not found');

  @override
  StringsI18n get strings {
    return StringsI18n(
        loginPage: loginPage,
        notePage: notePage,
        general: general,
        validators: validators,
        authError: authError,
        noteError: noteError);
  }
}
