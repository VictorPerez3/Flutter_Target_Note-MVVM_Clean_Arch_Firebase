import 'package:flutter/material.dart';
import 'package:flutter_project_target/features/auth/sign_up/presentation/tag/sign_up_tag.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/base/abstractions/custom_exception_interface.dart';
import '../../../../core/base/mixins/analytics_mixin.dart';
import '../../../../core/base/mixins/l18n_mixin.dart';
import '../../../../core/base/mixins/viewmodel_mixin.dart';
import '../../../../core/base/utils/snackbar_util.dart';
import '../../../../core/navigation/routes.dart';
import '../../../shared/loading/loading_widget.dart';
import '../../../shared/widgets/auth/auth_text_field_widget.dart';
import '../../../shared/widgets/general/background_box_decoration_widget.dart';
import '../../../shared/widgets/auth/go_sign_in_up_label_widget.dart';
import 'sign_up_viewmodel.dart';

class SignUpScreen extends StatelessWidget
    with ViewModelMixin<SignUpViewModel>, AnalyticsMixin<SignUpTag>, l18nMixin {
  const SignUpScreen({super.key});

  void createUser(BuildContext context) async {
    try {
      FocusScope.of(context).unfocus();
      await tag.onCreateUserEvent(l18n.strings.loginPage.signUpButtonLabel);
      final userId = await viewModel.createUser();
      if (userId != null) {
        if (context.mounted) {
          showSuccessSnackbar(
              context: context,
              title: l18n.strings.general.sucessToast,
              message: l18n.strings.loginPage.addUserToast);
          goSignIn(context);
        }
      }
    } on CustomException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    }
  }

  void goSignIn(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (context.mounted) {
      context.goNamed(Routes.signIn);
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
                decoration: backgroundBoxDecoration(signIn: false),
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 100.0),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            l18n.strings.loginPage.titleSignUpLabel,
                            style: const TextStyle(
                              color: Color(0xFF939393),
                              fontSize: 45.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 60.0),
                        Column(
                          children: [
                            AuthTextField(
                              labelText:
                                  l18n.strings.loginPage.completeNameLabel,
                              field: viewModel.completeNameField,
                            ),
                            const SizedBox(height: 32.0),
                            AuthTextField(
                              labelText: l18n.strings.loginPage.emailLabel,
                              field: viewModel.usernameField,
                            ),
                            const SizedBox(height: 32.0),
                            AuthTextField(
                              labelText: l18n.strings.loginPage.passwordLabel,
                              field: viewModel.passwordField,
                              obscureText: true,
                            ),
                            const SizedBox(height: 32.0),
                            AuthTextField(
                              labelText:
                                  l18n.strings.loginPage.repeatPasswordLabel,
                              field: viewModel.repeatPasswordField,
                              obscureText: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 42.0),
                        ValueListenableBuilder<bool>(
                          valueListenable: viewModel.enableSignUpButton,
                          builder: (context, isEnabled, _) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isEnabled
                                    ? () => createUser(context)
                                    : null,
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                    (states) {
                                      if (!isEnabled) {
                                        return const Color(0x0CD0BCFF);
                                      }
                                      return const Color(0xFF25232A);
                                    },
                                  ),
                                ),
                                child: Text(
                                  l18n.strings.loginPage.signUpButtonLabel,
                                  style: const TextStyle(
                                      color: Color(0xFFD0BCFF),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 0.10,
                                      letterSpacing: 0.10),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 26.0),
                        GoSignInUpLabel(goSignInUp: goSignIn, signIn: false),
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
