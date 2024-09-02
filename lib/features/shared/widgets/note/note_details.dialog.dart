import 'package:flutter/material.dart';

import '../../../../core/base/mixins/l18n.mixin.dart';

class NoteDetailsDialog extends StatelessWidget with l18nMixin {
  final ValueNotifier<String?> titleField;
  final ValueNotifier<String?> noteTextField;
  final ValueNotifier<bool> isSaveButtonEnabled;
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onNoteTextChanged;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const NoteDetailsDialog({
    super.key,
    required this.titleField,
    required this.noteTextField,
    required this.isSaveButtonEnabled,
    required this.onTitleChanged,
    required this.onNoteTextChanged,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l18n.strings.notePage.textLabelModal,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  l18n.strings.notePage.titleLabelModal,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              ValueListenableBuilder<String?>(
                valueListenable: titleField,
                builder: (context, titleValue, child) {
                  final controller = TextEditingController(text: titleValue);
                  controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: controller.text.length));
                  return TextField(
                    onChanged: (value) {
                      onTitleChanged(value);
                      controller.value = controller.value.copyWith(
                        text: value,
                        selection: TextSelection.fromPosition(
                          TextPosition(offset: value.length),
                        ),
                      );
                    },
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      alignLabelWithHint: true,
                    ),
                    textAlignVertical: TextAlignVertical.top,
                  );
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  l18n.strings.notePage.noteTextLabelModal,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Expanded(
                child: ValueListenableBuilder<String?>(
                  valueListenable: noteTextField,
                  builder: (context, noteTextValue, child) {
                    final controller =
                        TextEditingController(text: noteTextValue);
                    controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: controller.text.length));
                    return TextField(
                      onChanged: (value) {
                        onNoteTextChanged(value);
                        controller.value = controller.value.copyWith(
                          text: value,
                          selection: TextSelection.fromPosition(
                            TextPosition(offset: value.length),
                          ),
                        );
                      },
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        alignLabelWithHint: true,
                      ),
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: isSaveButtonEnabled,
                    builder: (context, isEnabled, child) {
                      return ElevatedButton(
                        onPressed: isEnabled ? onSave : null,
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                              return states.contains(WidgetState.disabled)
                                  ? Colors.grey
                                  : Colors.green;
                            },
                          ),
                        ),
                        child: Text(
                          l18n.strings.notePage.saveButton,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: onCancel,
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.green),
                    ),
                    child: Text(
                      l18n.strings.notePage.cancelButton,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
