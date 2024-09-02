import 'contexts/auth_error.strings.dart';
import 'contexts/auth_screen.strings.dart';
import 'contexts/general.strings.dart';
import 'contexts/note_error.strings.dart';
import 'contexts/note_screen.strings.dart';
import 'contexts/validators.strings.dart';
import 'translation.dart';

class EnUsStringsTranslations implements StringsTranslations {
  static const String getLocale = 'en-US';

  final loginPage = AuthScreenStrings(
    titleLabel: 'Project Target Note',
    userNameLabel: 'E-mail',
    passwordLabel: 'Password',
    signInButtonLabel: 'Join',
    signUpButtonLabel: 'Create User',
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
    privacyPolicyUrlLabel: 'https://www.google.com.br',
  );

  final validators = ValidatorsStrings(
    invalidUsername: 'User is invalid',
    requiredUsername: 'User is required',
    invalidPassword: 'Password invalid: At least 6 characters',
    requiredPassword: 'Password is required',
    required: 'Field is required',
  );

  final authError = AuthErrorStrings(
      usernameMessage: 'Invalid Username',
      passwordMessage: 'Invalid Password',
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
