import 'package:flutter/material.dart';
import '../../../../core/base/abstractions/field_interface.dart';

class AuthTextField extends StatelessWidget {
  final String labelText;
  final IField<String> field;
  final bool obscureText;
  final IconData icon;

  const AuthTextField({
    super.key,
    required this.labelText,
    required this.field,
    this.obscureText = false,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          TextFormField(
            initialValue: field.valueNotifier.value,
            onChanged: (newValue) => field.onChange(newValue),
            obscureText: obscureText,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              filled: true,
              fillColor: const Color(0XFFF5F5F5),
              prefixIcon: Icon(
                icon,
                color: Colors.black,
              ),
              hintStyle: const TextStyle(
                color: Colors.deepPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
