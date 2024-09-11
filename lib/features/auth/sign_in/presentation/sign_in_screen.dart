import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_project_target/features/auth/sign_in/presentation/tag/sign_in_tag.dart';
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
import 'sign_in_viewmodel.dart';

class SignInScreen extends StatelessWidget
    with ViewModelMixin<SignInViewModel>, AnalyticsMixin<SignInTag>, l18nMixin {
  const SignInScreen({super.key});

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
    } on CustomException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    }
  }

  void goSignUp(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (context.mounted) {
      context.goNamed(Routes.signUp);
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
                decoration: backgroundBoxDecoration(signIn: true),
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100.0),
                        Text(
                          l18n.strings.loginPage.titleSignInLabel,
                          style: const TextStyle(
                            color: Color(0xFF939393),
                            fontSize: 54.0,
                            fontFamily: 'vibur',
                            fontWeight: FontWeight.w400,
                            height: 0.02,
                          ),
                        ),
                        const SizedBox(height: 90.0),
                        Column(
                          children: [
                            AuthTextField(
                              labelText: l18n.strings.loginPage.emailLabel,
                              field: viewModel.emailField,
                            ),
                            const SizedBox(height: 32.0),
                            AuthTextField(
                              labelText: l18n.strings.loginPage.passwordLabel,
                              field: viewModel.passwordField,
                              obscureText: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 42.0),
                        ValueListenableBuilder<bool>(
                          valueListenable: viewModel.enableSignInButton,
                          builder: (context, isEnabled, _) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isEnabled
                                    ? () => authenticateUser(context)
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
                                  l18n.strings.loginPage.signInButtonLabel,
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
                        const SizedBox(height: 16.0),
                        GoSignInUpLabel(goSignInUp: goSignUp, signIn: true),
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
