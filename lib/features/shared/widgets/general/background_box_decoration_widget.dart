import 'package:flutter/material.dart';

BoxDecoration backgroundBoxDecoration({required bool signIn}) {
  return BoxDecoration(
    color: Colors.black,
    image: DecorationImage(
      image: AssetImage(
        signIn
            ? 'assets/images/custom-background/bg-sign-in-screen.png'
            : 'assets/images/custom-background/bg-sign-up-screen.png',
      ),
      fit: BoxFit.cover,
    ),
  );
}
