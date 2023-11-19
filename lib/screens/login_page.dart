import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/general/background_box_decoration.dart';
import '../components/login/login_text_field.dart';
import '../components/general/privacy_policy_label.dart';
import '../constants/login/login.error.dart';
import '../constants/login/login.string.dart';
import '../stores/login_store/login_store.dart';
import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginStore = LoginStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      const Text(
                        stringTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      LoginTextField(
                        labelText: stringLabelTextUser,
                        initialValue: loginStore.username,
                        onChanged: loginStore.setUsername,
                        icon: Icons.person,
                      ),
                      LoginTextField(
                        labelText: stringLabelTextPassword,
                        initialValue: loginStore.password,
                        onChanged: loginStore.setPassword,
                        obscureText: true,
                        icon: Icons.lock,
                      ),
                      const SizedBox(height: 30.0),
                      Observer(
                        builder: (_) => Container(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: loginStore.isValid
                                ? () async {
                                    final result = await loginStore.login();
                                    handleLoginResult(context, result);
                                  }
                                : null,
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return Colors.grey;
                                  }
                                  return Colors.greenAccent;
                                },
                              ),
                            ),
                            child: const Text(
                              stringButton,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
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
    );
  }

  void handleLoginResult(BuildContext context, LoginResult result) {
    switch (result) {
      case LoginResult.success:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(),
          ),
        );
        break;
      case LoginResult.invalidUser:
        Fluttertoast.showToast(
            msg: errorToastInvalidUser,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        break;
      case LoginResult.invalidPassword:
        Fluttertoast.showToast(
            msg: errorToastInvalidPassword,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        break;
    }
  }
}
