import 'package:flutter/material.dart';
import 'package:flutter_project_target/features/auth/presentation/tag/auth_tag.dart';
import 'package:go_router/go_router.dart';
import '../../../core/base/mixins/analytics_mixin.dart';
import '../../../core/base/mixins/viewmodel_mixin.dart';
import '../../../core/base/mixins/l18n_mixin.dart';
import '../../../core/base/utils/snackbar_util.dart';
import '../../../core/navigation/routes.dart';
import '../../../core/resources/auth/domain/exceptions/email_already_in_use_exception.dart';
import '../../../core/resources/auth/domain/exceptions/invalid_email_exception.dart';
import '../../../core/resources/auth/domain/exceptions/network_request_failed_exception.dart';
import '../../../core/resources/auth/domain/exceptions/other_auth_exception.dart';
import '../../../core/resources/auth/domain/exceptions/passwords_do_not_match_exception.dart';
import '../../../core/resources/auth/domain/exceptions/username_or_password_incorrect_exception.dart';
import '../../shared/loading/loading_widget.dart';
import '../../shared/widgets/auth/auth_text_field_widget.dart';
import '../../shared/widgets/general/background_box_decoration_widget.dart';
import '../../shared/widgets/general/privacy_policy_label_widget.dart';
import '../../shared/widgets/auth/segmented_button_auth_widget.dart';
import 'auth_viewmodel.dart';

class AuthScreen extends StatelessWidget
    with ViewModelMixin<AuthViewModel>, AnalyticsMixin<AuthTag>, l18nMixin {
  const AuthScreen({super.key});

  void handleAuthAction(BuildContext context) {
    if (viewModel.isSignInMode.value) {
      authenticateUser(context);
    } else {
      createUser(context);
    }
  }

  void authenticateUser(BuildContext context) async {
    try {
      FocusScope.of(context).unfocus();
      await tag.onLoginEvent(l18n.strings.loginPage.signInButtonLabel);
      final userId = await viewModel.authenticateUser();
      if (userId != null) {
        await tag.onLoginSucceed(userId);
        if (context.mounted) {
          context.goNamed(Routes.note);
        }
      }
    } on UsernameOrPasswordIncorrectException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    } on OtherAuthException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    }
  }

  void createUser(BuildContext context) async {
    try {
      FocusScope.of(context).unfocus();
      await tag
          .onCreateUserEvent(l18n.strings.loginPage.signUpButtonLabel);
      final userId = await viewModel.createUser();
      if (userId != null) {
        if (context.mounted) {
          showSuccessSnackbar(
              context: context,
              title: l18n.strings.general.sucessToast,
              message: l18n.strings.loginPage.addUserToast);
        }
      }
    } on OtherAuthException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    } on EmailAlreadyInUseException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    } on InvalidEmailException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    } on PasswordsDoNotMatchException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    } on NetworkRequestFailedException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Container(
                decoration: backgroundBoxDecoration(),
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30.0),
                        Text(
                          l18n.strings.loginPage.titleLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: viewModel.isSignInMode,
                          builder: (context, isSignInMode, _) {
                            return Column(
                              children: [
                                if (!isSignInMode)
                                  AuthTextField(
                                    labelText: "Nome Completo",
                                    field: viewModel.completeNameField,
                                    icon: Icons.person,
                                  ),
                                AuthTextField(
                                  labelText:
                                      l18n.strings.loginPage.userNameLabel,
                                  field: viewModel.usernameField,
                                  icon: Icons.person,
                                ),
                                AuthTextField(
                                  labelText:
                                      l18n.strings.loginPage.passwordLabel,
                                  field: viewModel.passwordField,
                                  obscureText: true,
                                  icon: Icons.lock,
                                ),
                                if (!isSignInMode)
                                  AuthTextField(
                                    labelText: "Repetir senha",
                                    field: viewModel.repeatPasswordField,
                                    obscureText: true,
                                    icon: Icons.lock,
                                  ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 30.0),
                        ValueListenableBuilder<bool>(
                          valueListenable: viewModel.enableSignInButton,
                          builder: (context, isEnabled, _) {
                            return SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                onPressed: isEnabled
                                    ? () => handleAuthAction(context)
                                    : null,
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                    (states) {
                                      if (!isEnabled) {
                                        return Colors.grey;
                                      }
                                      return Colors.green;
                                    },
                                  ),
                                ),
                                child: ValueListenableBuilder<bool>(
                                  valueListenable: viewModel.isSignInMode,
                                  builder: (context, isSignInMode, _) {
                                    return Text(
                                      isSignInMode
                                          ? l18n.strings.loginPage
                                              .signInButtonLabel
                                          : l18n.strings.loginPage
                                              .signUpButtonLabel,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 30.0),
                        SegmentedButtonAuth(
                          isSignInMode: viewModel.isSignInMode,
                          onToggle: viewModel.toggleSignInSignUp,
                        ),
                        const Spacer(),
                        const PrivacyPolicyLabel(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
