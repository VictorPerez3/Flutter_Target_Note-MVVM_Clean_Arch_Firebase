import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/base/constants/general.string.dart';
import '../../../../core/base/mixins/l18n.mixin.dart';

class PrivacyPolicyLabel extends StatelessWidget with l18nMixin {
  const PrivacyPolicyLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () => _launchURL(),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            l18n.strings.general.privacyPolicyLabel,
            style: const TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL() async {
    final Uri url = Uri.parse(GeneralConstants.strPrivacyPolicyUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
