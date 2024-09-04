import 'package:flutter/material.dart';
import 'package:flutter_project_target/features/note/presentation/note_viewmodel.dart';

import '../../../../core/resources/note/domain/entities/note.entity.dart';
import 'note_icon_button_widget.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;
  final NoteViewModel controller;
  final Function({Note? note, required BuildContext context})
      showNoteDetailsDialog;

  const NoteList({
    super.key,
    required this.notes,
    required this.controller,
    required this.showNoteDetailsDialog,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 10),
      itemCount: notes.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final note = notes[index];
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      controller.getDisplayText(note),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NoteIconButton(
                    iconColor: Colors.red,
                    icon: Icons.cancel,
                    note: note,
                    noteController: controller,
                  ),
                ],
              ),
            ],
          ),
          onTap: () => showNoteDetailsDialog(note: note, context: context),
        );
      },
    );
  }
}
