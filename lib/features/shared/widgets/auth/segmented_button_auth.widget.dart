import 'package:flutter/material.dart';
import 'package:flutter_project_target/core/base/constants/notes.string.dart';

class SegmentedButtonAuth extends StatelessWidget {
  final ValueNotifier<bool> isSignInMode;
  final VoidCallback onToggle;

  const SegmentedButtonAuth({
    super.key,
    required this.isSignInMode,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isSignInMode,
      builder: (context, isSignInMode, _) {
        return SegmentedButton<bool>(
          segments: const <ButtonSegment<bool>>[
            ButtonSegment<bool>(
                value: true, label: Text(NotesConstants.signIn)),
            ButtonSegment<bool>(
                value: false, label: Text(NotesConstants.signUp)),
          ],
          selected: {isSignInMode},
          showSelectedIcon: false,
          onSelectionChanged: (Set<bool> newSelection) {
            if (newSelection.contains(!isSignInMode)) {
              onToggle();
            }
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white.withOpacity(0.9);
              }
              return Colors.white.withOpacity(0.6);
            }),
          ),
        );
      },
    );
  }
}
