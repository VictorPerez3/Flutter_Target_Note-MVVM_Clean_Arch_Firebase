import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final String labelText;
  final String initialValue;
  final Function(String) onChanged;
  final bool obscureText;
  final IconData icon;

  const LoginTextField({
    Key? key,
    required this.labelText,
    required this.initialValue,
    required this.onChanged,
    this.obscureText = false,
    required this.icon,
  }) : super(key: key);

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
            initialValue: initialValue,
            onChanged: onChanged,
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
