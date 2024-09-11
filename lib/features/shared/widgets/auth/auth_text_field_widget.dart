import 'package:flutter/material.dart';
import '../../../../core/base/abstractions/field_interface.dart';

class AuthTextField extends StatelessWidget {
  final String labelText;
  final IField<String> field;
  final bool obscureText;

  const AuthTextField({
    super.key,
    required this.labelText,
    required this.field,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: field.valueNotifier.value,
          onChanged: (newValue) => field.onChange(newValue),
          obscureText: obscureText,
          style: const TextStyle(
            color: Color(0xFFCAC4D0),
          ),
          decoration: InputDecoration(
            hintText: labelText,
            hintStyle: const TextStyle(
              color: Color(0xFFCAC4D0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
