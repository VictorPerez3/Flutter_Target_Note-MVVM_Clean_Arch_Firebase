import 'package:flutter/material.dart';

import '../../../../core/base/mixins/l18n_mixin.dart';

class SegmentedButtonNote extends StatelessWidget with l18nMixin {
  final ValueNotifier<String> noteTypeMode;

  const SegmentedButtonNote({
    super.key,
    required this.noteTypeMode,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: noteTypeMode,
      builder: (context, selectedMode, _) {
        return SegmentedButton<String>(
          segments: <ButtonSegment<String>>[
            ButtonSegment<String>(
              value: "notes",
              label:
                  Center(child: Text(l18n.strings.notePage.notesButtonSegment)),
            ),
            ButtonSegment<String>(
              value: "personal_accounts",
              label: Center(
                  child: Text(
                      l18n.strings.notePage.personalAccountsButtonSegment)),
            ),
            ButtonSegment<String>(
              value: "bank_notes",
              label: Center(
                  child: Text(l18n.strings.notePage.bankNotesButtonSegment)),
            ),
          ],
          selected: {selectedMode},
          showSelectedIcon: false,
          onSelectionChanged: (Set<String> newSelection) {
            if (newSelection.isNotEmpty) {
              noteTypeMode.value = newSelection.first;
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
