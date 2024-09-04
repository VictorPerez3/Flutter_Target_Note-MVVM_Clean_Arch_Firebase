import 'package:flutter/material.dart';

BoxDecoration backgroundBoxDecoration() {
  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF00796B), Color(0xFFB2DFDB)],
    ),
  );
}