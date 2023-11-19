import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyLabel extends StatelessWidget {
  const PrivacyPolicyLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: _launchURL,
        child: const Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Política de Privacidade',
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
    final Uri url = Uri.parse('https://www.google.com.br');
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
