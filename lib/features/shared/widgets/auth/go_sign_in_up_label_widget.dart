import 'package:flutter/material.dart';
import '../../../../core/base/mixins/l18n_mixin.dart';

class GoSignInUpLabel extends StatelessWidget with l18nMixin {
  final bool signIn;
  final void Function(BuildContext) goSignInUp;

  const GoSignInUpLabel({
    super.key,
    required this.signIn,
    required this.goSignInUp,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 33.0),
          child: Text(
            signIn
                ? l18n.strings.loginPage.signInTextLabel
                : l18n.strings.loginPage.signUpTextLabel,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF49454F),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => goSignInUp(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 24.5),
            child: Text(
              signIn
                  ? l18n.strings.loginPage.signUpButtonLabel
                  : l18n.strings.loginPage.signInButtonLabel,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFFD0BCFF),
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
