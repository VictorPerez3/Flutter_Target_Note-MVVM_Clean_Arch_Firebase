import 'package:flutter/material.dart';
import '../../../../core/base/mixins/l18n_mixin.dart';
import '../../../../core/resources/note/domain/constants/note_types_and_hide_constants.dart';

class NoteTypesButton extends StatelessWidget with l18nMixin {
  final ValueNotifier<String> noteTypeMode;

  const NoteTypesButton({
    super.key,
    required this.noteTypeMode,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: noteTypeMode,
      builder: (context, selectedMode, _) {
        final listButtons = [
          {
            'value': NoteTypesAndHideConstants.generalNotes,
            'label': l18n.strings.notePage.generalNotesButtonSegment,
          },
          {
            'value': NoteTypesAndHideConstants.personalAccounts,
            'label': l18n.strings.notePage.personalAccountsButtonSegment,
          },
          {
            'value': NoteTypesAndHideConstants.bankNotes,
            'label': l18n.strings.notePage.bankNotesButtonSegment,
          },
          {
            'value': NoteTypesAndHideConstants.hiddenNotes,
            'label': l18n.strings.notePage.hiddenNotesButtonSegment,
          },
        ];

        return SizedBox(
          height: 55,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(listButtons.length * 2 - 1, (index) {
                if (index % 2 == 1) {
                  return const SizedBox(width: 18);
                } else {
                  final buttonIndex = index ~/ 2;
                  final button = listButtons[buttonIndex];
                  final isSelected = selectedMode == button['value'];

                  return ElevatedButton(
                    onPressed: () {
                      noteTypeMode.value = button['value']!;
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 16),
                      backgroundColor: isSelected
                          ? const Color(0xFF39363e)
                          : const Color(0xFF25232a),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      button['label']!,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 20 / 14,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              }),
            ),
          ),
        );
      },
    );
  }
}
