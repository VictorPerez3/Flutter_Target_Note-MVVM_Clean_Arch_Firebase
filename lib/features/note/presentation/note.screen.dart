import 'package:flutter/material.dart';
import 'package:flutter_project_target/core/resources/note/domain/exceptions/decrypt_fail.exception.dart';
import 'package:flutter_project_target/core/resources/note/domain/exceptions/note_not_found.exception.dart';
import 'package:flutter_project_target/core/resources/note/domain/exceptions/operation_note_fail.exception.dart';
import 'package:flutter_project_target/core/resources/note/domain/exceptions/userid_not_found.exception.dart';
import 'package:flutter_project_target/features/note/presentation/note.viewmodel.dart';
import 'package:flutter_project_target/features/note/presentation/tag/note.tag.dart';
import 'package:go_router/go_router.dart';

import '../../../core/base/abstractions/custom_exception.interface.dart';
import '../../../core/base/mixins/analytics.mixin.dart';
import '../../../core/base/mixins/viewmodel.mixin.dart';
import '../../../core/base/mixins/l18n.mixin.dart';
import '../../../core/base/utils/snackbar.util.dart';
import '../../../core/navigation/routes.dart';
import '../../../core/resources/note/domain/entities/note.entity.dart';
import '../../shared/loading/loading.widget.dart';
import '../../shared/widgets/general/background_box_decoration.widget.dart';
import '../../shared/widgets/general/privacy_policy_label.widget.dart';
import '../../shared/widgets/note/appbar.widget.dart';
import '../../shared/widgets/note/note_details.dialog.dart';
import '../../shared/widgets/note/note_list.widget.dart';
import '../../shared/widgets/note/segmented_button_note.widget.dart';

class NoteScreen extends StatelessWidget
    with ViewModelMixin<NoteViewModel>, AnalyticsMixin<NoteTag>, l18nMixin {
  const NoteScreen({super.key});

  void logout(BuildContext context) async {
    try {
      FocusScope.of(context).unfocus();
      await tag.onLogoutEvent("Logout");
      viewModel.logout();
      if (context.mounted) {
        context.goNamed(Routes.auth);
      }
    } on CustomException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    }
  }

  void _showNoteDetailsDialog({Note? note, required BuildContext context}) {
    if (note != null) {
      viewModel.titleField.valueNotifier.value = note.title;
      viewModel.noteTextField.valueNotifier.value = note.noteText;
    } else {
      viewModel.titleField.valueNotifier.value = '';
      viewModel.noteTextField.valueNotifier.value = '';
    }

    void handleSaveEditNote() async {
      try {
        if (note == null) {
          tag.onSaveNoteEvent(l18n.strings.notePage.addItemToast);
          viewModel.addNote(
            title: viewModel.titleField.valueNotifier.value!,
            noteText: viewModel.noteTextField.valueNotifier.value!,
          );
          showSuccessSnackbar(
              context: context,
              title: l18n.strings.general.sucessToast,
              message: l18n.strings.notePage.addItemToast);
        } else {
          tag.onEditNoteEvent(l18n.strings.notePage.editItemToast);
          viewModel.editNote(
            noteId: note.id,
            title: viewModel.titleField.valueNotifier.value!,
            noteText: viewModel.noteTextField.valueNotifier.value!,
          );
          showSuccessSnackbar(
              context: context,
              title: l18n.strings.general.sucessToast,
              message: l18n.strings.notePage.editItemToast);
        }
      } on OperationNoteFailException catch (err) {
        if (context.mounted) showErrorSnackbar(context: context, err: err);
      } on UseridNotFoundException catch (err) {
        if (context.mounted) showErrorSnackbar(context: context, err: err);
      } on NoteNotFoundException catch (err) {
        if (context.mounted) showErrorSnackbar(context: context, err: err);
      } on DecryptFailException catch (err) {
        if (context.mounted) showErrorSnackbar(context: context, err: err);
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NoteDetailsDialog(
          titleField: viewModel.titleField.valueNotifier,
          noteTextField: viewModel.noteTextField.valueNotifier,
          isSaveButtonEnabled: viewModel.isSaveButtonEnabled,
          onTitleChanged: (value) {
            viewModel.titleField.onChange(value);
          },
          onNoteTextChanged: (value) {
            viewModel.noteTextField.onChange(value);
          },
          onSave: () {
            handleSaveEditNote();
            Navigator.of(context).pop();
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Scaffold(
        appBar: CustomAppBar(onLogout: () => logout(context)),
        body: Container(
          decoration: backgroundBoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
            child: Column(
              children: [
                SegmentedButtonNote(
                  noteTypeMode: viewModel.noteTypeMode,
                ),
                const SizedBox(height: 10),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: ValueListenableBuilder<List<Note>>(
                      valueListenable: viewModel.notes,
                      builder: (context, notes, child) {
                        return NoteList(
                          notes: notes,
                          controller: viewModel,
                          showNoteDetailsDialog: _showNoteDetailsDialog,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => _showNoteDetailsDialog(context: context),
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.green),
                    ),
                    child: Text(
                      l18n.strings.notePage.newRegisterButton,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(flex: 1),
                    Align(
                      alignment: Alignment.center,
                      child: PrivacyPolicyLabel(),
                    ),
                    Spacer(flex: 1),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
