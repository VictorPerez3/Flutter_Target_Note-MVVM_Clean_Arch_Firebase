import 'package:flutter/material.dart';
import 'package:flutter_project_target/screens/login_page.dart';
import 'constants/general/general.string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: stringProjectName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const LoginPage()
    );
  }
}