import 'package:flutter/material.dart';

import '../../constants/dashboard/dashboard.string.dart';
import '../../stores/dashboard_store/dashboard_store.dart';

class DashboardTextField extends StatelessWidget {
  const DashboardTextField({
    super.key,
    required this.textEditingController,
    required this.focusNode,
    required this.store,
  });

  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final DashboardStore store;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      focusNode: focusNode,
      onSubmitted: (value) {
        store.handleSubmit(value);
        textEditingController.clear();
      },
      decoration: InputDecoration(
        labelText: stringLabelTextField,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }
}
