import 'package:flutter/cupertino.dart';
import '../../../../core/base/abstractions/field_interface.dart';
import '../../../../core/base/dal/data/error_data.dart';
import '../../../../core/base/mixins/l18n_mixin.dart';
import '../../../../core/resources/auth/domain/constants/auth_errors_constants.dart';
import '../../../../core/resources/auth/domain/exceptions/passwords_do_not_match_exception.dart';
import '../../../../core/base/abstractions/viewmodel_interface.dart';
import '../../../../core/resources/auth/domain/usecases/sign_up_usecase.dart';

class SignUpViewModel extends IViewModel with l18nMixin {
  final SignUpUsecase _signUpUsecase;
  final IField<String> completeNameField;
  final IField<String> usernameField;
  final IField<String> passwordField;
  final IField<String> repeatPasswordField;
  final enableSignUpButton = ValueNotifier<bool>(false);

  SignUpViewModel({
    required this.completeNameField,
    required this.usernameField,
    required this.passwordField,
    required this.repeatPasswordField,
    required SignUpUsecase signUpUsecase,
  }) : _signUpUsecase = signUpUsecase {
    _setupReactionsSignUp();
  }

  void _setupReactionsSignUp() {
    completeNameField.valueNotifier.addListener(_updateSignUpButtonState);
    usernameField.valueNotifier.addListener(_updateSignUpButtonState);
    passwordField.valueNotifier.addListener(_updateSignUpButtonState);
    repeatPasswordField.valueNotifier.addListener(_updateSignUpButtonState);
  }

  void _updateSignUpButtonState() {
    enableSignUpButton.value = _validateFieldsSignUp;
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

      final userId = await _signUpUsecase.signUp(
        email: usernameField.valueNotifier.value!,
        password: passwordField.valueNotifier.value!,
      );
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

  @override
  void dispose() {
    completeNameField.dispose();
    usernameField.dispose();
    passwordField.dispose();
    repeatPasswordField.dispose();
  }
}