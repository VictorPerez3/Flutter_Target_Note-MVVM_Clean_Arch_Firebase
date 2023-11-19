import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/general/general.string.dart';

class PrivacyPolicyLabel extends StatelessWidget {
  final bool isActive;

  const PrivacyPolicyLabel({Key? key, this.isActive = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          if (isActive) _launchURL();
        },
        child: const Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            stringPrivacyPolicyLabel,
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL() async {
    final Uri url = Uri.parse(stringPrivacyPolicyUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
