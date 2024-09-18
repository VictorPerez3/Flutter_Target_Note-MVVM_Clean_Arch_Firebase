import 'package:flutter/material.dart';

import '../../../../core/resources/note/domain/entities/note.entity.dart';
import '../../../../core/base/abstractions/custom_exception_interface.dart';
import '../../../../core/base/mixins/analytics_mixin.dart';
import '../../../../core/base/mixins/l18n_mixin.dart';
import '../../../../core/base/utils/snackbar_util.dart';
import '../../../note/list/presentation/note_list_viewmodel.dart';
import '../../../note/list/presentation/tag/note_list_tag.dart';

class NoteList extends StatelessWidget
    with l18nMixin, AnalyticsMixin<NoteListTag> {
  final List<Note> notes;
  final NoteListViewModel controller;
  final Function({Note? note, required BuildContext context}) goNoteDetails;

  const NoteList({
    super.key,
    required this.notes,
    required this.controller,
    required this.goNoteDetails,
  });

  void handleDeleteNote({
    required Note note,
    required NoteListViewModel noteController,
    required BuildContext context,
  }) async {
    try {
      tag.onDeleteNoteEvent(l18n.strings.notePage.removeItemToast);
      noteController.removeNote(note.id);
      if (context.mounted) {
        showSuccessSnackbar(
            context: context,
            title: l18n.strings.general.sucessToast,
            message: l18n.strings.notePage.removeItemToast);
      }
    } on CustomException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    }
  }

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
                  deleteNoteIcon(
                    note: note,
                    noteController: controller,
                    icon: Icons.cancel,
                    iconColor: Colors.red,
                    context: context,
                  ),
                ],
              ),
            ],
          ),
          onTap: () => goNoteDetails(note: note, context: context),
        );
      },
    );
  }

  Widget deleteNoteIcon({
    required Note note,
    required NoteListViewModel noteController,
    required IconData icon,
    required Color iconColor,
    required BuildContext context,
  }) {
    return IconButton(
      icon: Icon(icon, color: iconColor),
      onPressed: () {
        handleDeleteNote(
            note: note, noteController: noteController, context: context);
      },
    );
  }
}
