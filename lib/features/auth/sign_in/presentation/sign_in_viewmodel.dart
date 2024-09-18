import 'package:flutter/cupertino.dart';
import '../../../../core/base/abstractions/field_interface.dart';
import '../../../../core/base/mixins/l18n_mixin.dart';
import '../../../../core/resources/auth/domain/usecases/sign_in_usecase.dart';
import '../../../../core/base/abstractions/viewmodel_interface.dart';

class SignInViewModel extends IViewModel with l18nMixin {
  final SignInUsecase _signInUsecase;
  final IField<String> emailField;
  final IField<String> passwordField;
  final enableSignInButton = ValueNotifier<bool>(false);

  SignInViewModel({
    required this.emailField,
    required this.passwordField,
    required SignInUsecase signInUsecase,
  }) : _signInUsecase = signInUsecase {
    _setupReactionsSignIn();

    // Inicializar os campos com valores padrão
    emailField.valueNotifier.value = 'teste@teste.com';
    passwordField.valueNotifier.value = 'teste123';
    //////////////////////////////////////////
  }

  void _setupReactionsSignIn() {
    emailField.valueNotifier.addListener(_updateSignInButtonState);
    passwordField.valueNotifier.addListener(_updateSignInButtonState);
  }

  void _updateSignInButtonState() {
    enableSignInButton.value = _validateFieldsSignIn;
  }

  Future<String?> authenticateUser() async {
    try {
      loading.isLoading = true;
      final userId = await _signInUsecase.signIn(
        email: emailField.valueNotifier.value!,
        password: passwordField.valueNotifier.value!,
      );
      return userId;
    } finally {
      loading.isLoading = false;
    }
  }

  bool get _validateFieldsSignIn {
    emailField.validate();
    passwordField.validate();
    return !emailField.hasError && !passwordField.hasError;
  }

  @override
  void dispose() {
    emailField.dispose();
    passwordField.dispose();
  }
}
