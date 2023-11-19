import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/login_text_field.dart';
import '../components/privacy_policy_label.dart';
import '../stores/form_store/form_store.dart';
import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formStore = FormStore();

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
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF00796B), Color(0xFFB2DFDB)],
                ),
              ),
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30.0),
                      const Text(
                        'Project Target',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      LoginTextField(
                        labelText: "Usuário",
                        initialValue: formStore.username,
                        onChanged: formStore.setUsername,
                        icon: Icons.person,
                      ),
                      LoginTextField(
                        labelText: "Senha",
                        initialValue: formStore.password,
                        onChanged: formStore.setPassword,
                        obscureText: true,
                        icon: Icons.lock,
                      ),
                      const SizedBox(height: 30.0),
                      Observer(
                        builder: (_) => Container(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: formStore.isValid
                                ? () async {
                                    final result = await formStore.login();
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
                              "Entrar",
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
            msg: "Usuário Inválido",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        break;
      case LoginResult.invalidPassword:
        Fluttertoast.showToast(
            msg: "Senha Inválida",
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
