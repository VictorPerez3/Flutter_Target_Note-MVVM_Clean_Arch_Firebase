import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      bottom: 13,
      child: Material(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: const Color(0xFF25232a),
        child: InkWell(
          onTap: onTap,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          splashColor: Colors.white12,
          highlightColor: Colors.white10,
          child: const SizedBox(
            width: 56,
            height: 56,
            child: Center(
              child: Icon(
                Icons.add,
                color: Color(0xFFD0BCFF),
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
