import 'package:flutter/material.dart';
import 'package:flutter_project_target/features/note/details/presentation/tag/note_details_tag.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/base/abstractions/custom_exception_interface.dart';
import '../../../../core/base/mixins/analytics_mixin.dart';
import '../../../../core/base/mixins/l18n_mixin.dart';
import '../../../../core/base/mixins/viewmodel_mixin.dart';
import '../../../../core/base/utils/date_time_util.dart';
import '../../../../core/base/utils/snackbar_util.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/resources/note/domain/entities/note.entity.dart';
import '../../../shared/loading/loading_widget.dart';
import 'note_details_viewmodel.dart';

class NoteDetailsScreen extends StatelessWidget
    with
        ViewModelMixin<NoteDetailsViewModel>,
        AnalyticsMixin<NoteDetailsTag>,
        l18nMixin {
  final Note? note;

  const NoteDetailsScreen({super.key, required this.note});

  void getNoteItem() {
    if (note != null) {
      viewModel.titleField.valueNotifier.value = note!.title;
      viewModel.noteTextField.valueNotifier.value = note!.noteText;
    } else {
      viewModel.titleField.valueNotifier.value = '';
      viewModel.noteTextField.valueNotifier.value = '';
    }
  }

  void handleSaveEditNote(
      {required Note? note, required BuildContext context}) async {
    try {
      final titleFieldValue = viewModel.titleField.valueNotifier.value;
      final noteTextFieldValue = viewModel.noteTextField.valueNotifier.value;

      final fieldValueFilled =
          titleFieldValue != '' && noteTextFieldValue != '';
      final fieldValueModified = titleFieldValue != note?.title ||
          noteTextFieldValue != note?.noteText;
      final onSaveEditAuthorized = fieldValueFilled && fieldValueModified;

      if (note == null && onSaveEditAuthorized) {
        tag.onSaveNoteEvent(l18n.strings.notePage.addItemToast);
        viewModel.addNote(
            title: titleFieldValue!,
            noteText: noteTextFieldValue!,

            //////////////////////////////////
            hashtags: ['work', 'travel']); //hashtags mockado
        //////////////////////////////////

        showSuccessSnackbar(
            context: context,
            title: l18n.strings.general.sucessToast,
            message: l18n.strings.notePage.addItemToast);
      }

      if (note != null && onSaveEditAuthorized) {
        tag.onEditNoteEvent(l18n.strings.notePage.editItemToast);
        viewModel.editNote(
            noteId: note.id,
            title: titleFieldValue!,
            noteText: noteTextFieldValue!,

            //////////////////////////////////
            hashtags: ['work', 'travel']); //hashtags mockado
        //////////////////////////////////

        showSuccessSnackbar(
            context: context,
            title: l18n.strings.general.sucessToast,
            message: l18n.strings.notePage.editItemToast);
      }
    } on CustomException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    }
  }

  void handleBack({required Note? note, required BuildContext context}) async {
    FocusScope.of(context).unfocus();
    if (context.mounted) {
      handleSaveEditNote(context: context, note: note);
      tag.onDetailToListEvent("Details screen to List Screen");
      context.goNamed(Routes.noteList);
    }
  }

  @override
  Widget build(BuildContext context) {
    getNoteItem();
    return LoadingWidget(
      child: Scaffold(
        backgroundColor: const Color(0xFF1C1B1F),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 40, 12, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      arrowBackIcon(context: context, note: note),
                      const SizedBox(height: 15.0),
                      ValueListenableBuilder<String?>(
                        valueListenable: viewModel.titleField.valueNotifier,
                        builder: (context, title, child) {
                          return TextFormField(
                            initialValue: title,
                            onChanged: (newValue) =>
                                viewModel.titleField.onChange(newValue),
                            maxLines: 2,
                            maxLength: 40,
                            style: const TextStyle(
                              color: Color(0xFF79747E),
                              fontSize: 32,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText: l18n.strings.notePage.titleLabelModal,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                          );
                        },
                      ),
                      Text(
                        note?.updatedAt == null
                            ? 'Created at ${DateTimeUtil.formatDate(DateTimeUtil.getCurrentDateTime())}'
                            : 'Updated at ${DateTimeUtil.formatDate(note!.updatedAt)}',
                        maxLines: 1,
                        style: const TextStyle(
                          color: Color(0xFF79747E),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      ValueListenableBuilder<String?>(
                        valueListenable: viewModel.noteTextField.valueNotifier,
                        builder: (context, noteText, child) {
                          return TextFormField(
                            initialValue: noteText,
                            onChanged: (newValue) =>
                                viewModel.noteTextField.onChange(newValue),
                            style: const TextStyle(
                              color: Color(0xFF79747E),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText:
                                  l18n.strings.notePage.noteTextLabelModal,
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget arrowBackIcon({required BuildContext context, required Note? note}) {
    return Container(
      width: 50,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFF25232A),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back-icon.svg',
          width: 18,
          height: 18,
        ),
        onPressed: () {
          handleBack(context: context, note: note);
        },
      ),
    );
  }
}
