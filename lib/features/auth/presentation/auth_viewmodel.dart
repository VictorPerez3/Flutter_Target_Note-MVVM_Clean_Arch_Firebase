import 'package:flutter/cupertino.dart';
import '../../../../core/base/abstractions/field_interface.dart';
import '../../../core/base/abstractions/viewmodel_interface.dart';
import '../../../core/base/dal/data/error_data.dart';
import '../../../core/base/mixins/l18n_mixin.dart';
import '../../../core/resources/auth/domain/constants/auth_errors_constants.dart';
import '../../../core/resources/auth/domain/exceptions/passwords_do_not_match_exception.dart';
import '../../../core/resources/auth/domain/usecases/auth_usecase.dart';

class AuthViewModel extends IViewModel with l18nMixin {
  final AuthUsecase _authenticateUsecase;
  final IField<String> completeNameField;
  final IField<String> usernameField;
  final IField<String> passwordField;
  final IField<String> repeatPasswordField;
  final enableSignInButton = ValueNotifier<bool>(false);
  final enableSignUpButton = ValueNotifier<bool>(false);
  final isSignInMode = ValueNotifier<bool>(true);

  AuthViewModel({
    required this.completeNameField,
    required this.usernameField,
    required this.passwordField,
    required this.repeatPasswordField,
    required AuthUsecase authenticateUsecase,
  }) : _authenticateUsecase = authenticateUsecase {
    _setupReactionsSignIn();
    _setupReactionsSignUp();

    // // Inicializar os campos com valores padrão
    // usernameField.valueNotifier.value = 'teste@teste.com';
    // passwordField.valueNotifier.value = 'teste123';
    // //////////////////////////////////////////
  }

  void _setupReactionsSignIn() {
    usernameField.valueNotifier.addListener(_updateSignInButtonState);
    passwordField.valueNotifier.addListener(_updateSignInButtonState);
  }

  void _setupReactionsSignUp() {
    completeNameField.valueNotifier.addListener(_updateSignUpButtonState);
    usernameField.valueNotifier.addListener(_updateSignUpButtonState);
    passwordField.valueNotifier.addListener(_updateSignUpButtonState);
    repeatPasswordField.valueNotifier.addListener(_updateSignUpButtonState);
  }

  void _updateSignInButtonState() {
    enableSignInButton.value = _validateFieldsSignIn;
  }

  void _updateSignUpButtonState() {
    enableSignUpButton.value = _validateFieldsSignUp;
  }

  void toggleSignInSignUp() {
    isSignInMode.value = !isSignInMode.value;
  }

  Future<String?> authenticateUser() async {
    try {
      loading.isLoading = true;
      final userId = await _authenticateUsecase.signIn(
        username: usernameField.valueNotifier.value!,
        password: passwordField.valueNotifier.value!,
      );
      return userId;
    } finally {
      loading.isLoading = false;
    }
  }

  Future<String?> createUser() async {
    try {
      loading.isLoading = true;

      if (passwordField.valueNotifier.value !=
          repeatPasswordField.valueNotifier.value) {
        throw PasswordsDoNotMatchException(
            failure: ErrorData(
          id: AuthErrorsConstants.passwordsDoNotMatchId,
          message: l18n.strings.authError.passwordsDoNotMatchMessage,
        ));
      }

      final userId = await _authenticateUsecase.signUp(
        username: usernameField.valueNotifier.value!,
        password: passwordField.valueNotifier.value!,
      );
      isSignInMode.value = !isSignInMode.value;
      return userId;
    } finally {
      loading.isLoading = false;
    }
  }

  bool get _validateFieldsSignUp {
    completeNameField.validate();
    usernameField.validate();
    passwordField.validate();
    repeatPasswordField.validate();
    return !completeNameField.hasError &&
        !usernameField.hasError &&
        !passwordField.hasError &&
        !repeatPasswordField.hasError;
  }

  bool get _validateFieldsSignIn {
    usernameField.validate();
    passwordField.validate();
    return !usernameField.hasError && !passwordField.hasError;
  }

  @override
  void dispose() {
    completeNameField.dispose();
    usernameField.dispose();
    passwordField.dispose();
    repeatPasswordField.dispose();
  }
}
