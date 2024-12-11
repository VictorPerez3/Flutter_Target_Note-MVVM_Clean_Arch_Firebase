import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArrowBackIcon extends StatelessWidget {
  final VoidCallback onPressed;

  const ArrowBackIcon({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      color: const Color(0xFF25232A),
      child: SizedBox(
        width: 50,
        height: 40,
        child: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back-icon.svg',
            width: 18,
            height: 18,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
