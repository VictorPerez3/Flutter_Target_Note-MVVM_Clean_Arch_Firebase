import 'package:flutter/material.dart';
import 'package:flutter_project_target/core/resources/note/domain/entities/note.entity.dart';

import '../../../../core/base/mixins/analytics_mixin.dart';
import '../../../../core/base/mixins/l18n_mixin.dart';
import '../../../../core/base/utils/snackbar_util.dart';
import '../../../../core/resources/note/domain/exceptions/note_not_found.exception.dart';
import '../../../../core/resources/note/domain/exceptions/operation_note_fail.exception.dart';
import '../../../../core/resources/note/domain/exceptions/userid_not_found.exception.dart';
import '../../../note/presentation/note_viewmodel.dart';
import '../../../note/presentation/tag/note_tag.dart';

class NoteIconButton extends StatelessWidget
    with l18nMixin, AnalyticsMixin<NoteTag> {
  final Note note;

  final NoteViewModel noteController;
  final IconData icon;
  final Color iconColor;

  const NoteIconButton({
    super.key,
    required this.note,
    required this.noteController,
    required this.icon,
    required this.iconColor,
  });

  void handleDeleteNote(BuildContext context) async {
    try {
      tag.onEditNoteEvent(l18n.strings.notePage.removeItemToast);
      noteController.removeNote(note.id);
      if (context.mounted) {
        showSuccessSnackbar(
            context: context,
            title: l18n.strings.general.sucessToast,
            message: l18n.strings.notePage.removeItemToast);
      }
    } on OperationNoteFailException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    } on UseridNotFoundException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    } on NoteNotFoundException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: iconColor),
      onPressed: () {
        handleDeleteNote(context);
      },
    );
  }
}
