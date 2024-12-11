import 'package:flutter/material.dart';
import 'package:flutter_project_target/features/note/details/presentation/tag/note_details_tag.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../../core/base/abstractions/custom_exception_interface.dart';
import '../../../../core/base/mixins/analytics_mixin.dart';
import '../../../../core/base/mixins/l18n_mixin.dart';
import '../../../../core/base/mixins/viewmodel_mixin.dart';
import '../../../../core/base/utils/date_time_util.dart';
import '../../../../core/base/utils/snackbar_util.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/resources/note/domain/constants/note_types_and_hide_constants.dart';
import '../../../../core/resources/note/domain/entities/note_entity.dart';
import '../../../shared/loading/loading_widget.dart';
import '../../../shared/widgets/note/arrow_back_icon_widget.dart';
import '../../../shared/widgets/note/bottom_sheet_widget.dart';
import 'note_details_viewmodel.dart';

class NoteDetailsScreen extends StatelessWidget
    with
        ViewModelMixin<NoteDetailsViewModel>,
        AnalyticsMixin<NoteDetailsTag>,
        l18nMixin {
  final Note? note;
  final String noteTypeMode;

  const NoteDetailsScreen({
    super.key,
    required this.note,
    required this.noteTypeMode,
  });

  void handleBack({required Note? note, required BuildContext context}) async {
    FocusScope.of(context).unfocus();
    if (context.mounted) {
      viewModel.handleSaveEditNote(
        note: note,
        onSaveSuccess: () {
          tag.onSaveNoteEvent(l18n.strings.notePage.addItemToast);
        },
        onEditSuccess: () {
          tag.onEditNoteEvent(l18n.strings.notePage.editItemToast);
        },
        onError: (err) {
          showErrorSnackbar(context: context, err: err as CustomException);
        },
      );
      tag.onDetailToListEvent("Details screen to List Screen");
      context.goNamed(Routes.noteList,
          extra: viewModel.getNoteTypeButtonByNoteList(note: note));
    }
  }

  String convertNoteTypeLabel({required String noteType}) {
    switch (noteType) {
      case NoteTypesAndHideConstants.generalNotes:
        return l18n.strings.notePage.generalNotesDetailsLabel;
      case NoteTypesAndHideConstants.personalAccounts:
        return l18n.strings.notePage.personalAccountsDetailsLabel;
      case NoteTypesAndHideConstants.bankNotes:
        return l18n.strings.notePage.bankNotesDetailsLabel;
      default:
        return l18n.strings.notePage.generalNotesDetailsLabel;
    }
  }

  String getNoteTypeLabel({required Note? note}) {
    if (note == null) {
      return convertNoteTypeLabel(noteType: noteTypeMode);
    } else {
      return convertNoteTypeLabel(noteType: note.noteType);
    }
  }

  @override
  Widget build(BuildContext context) {
    viewModel.initializeNote(note, noteTypeMode);

    return LoadingWidget(
      child: ValueListenableBuilder<Color>(
        valueListenable: viewModel.backgroundColor,
        builder: (context, viewModelBackgroundColor, child) {
          return Scaffold(
            backgroundColor: viewModelBackgroundColor,
            body: KeyboardVisibilityBuilder(
              builder: (context, isKeyboardVisible) {
                return Stack(
                  children: [
                    SingleChildScrollView(
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ArrowBackIcon(
                                        onPressed: () {
                                          handleBack(
                                              context: context, note: note);
                                        },
                                      ),
                                      Text(
                                        getNoteTypeLabel(note: note),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF49454F),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15.0),
                                  ValueListenableBuilder<String?>(
                                    valueListenable:
                                        viewModel.titleField.valueNotifier,
                                    builder: (context, title, child) {
                                      return TextFormField(
                                        initialValue: title,
                                        onChanged:
                                            viewModel.titleField.onChange,
                                        maxLines: 2,
                                        maxLength: 40,
                                        style: const TextStyle(
                                          color: Color(0xFF79747E),
                                          fontSize: 32,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: l18n
                                              .strings.notePage.titleLabelModal,
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                        keyboardType: TextInputType.multiline,
                                        textInputAction:
                                            TextInputAction.newline,
                                      );
                                    },
                                  ),
                                  Text(
                                    note?.updatedAt == null
                                        ? '${l18n.strings.notePage.createdAtLabel} ${DateTimeUtil.formatDateNoteDetails(DateTimeUtil.getCurrentDateTime())}'
                                        : '${l18n.strings.notePage.updatedAtLabel} ${DateTimeUtil.formatDateNoteDetails(note!.updatedAt)}',
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Color(0xFF79747E),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(height: 24.0),
                                  ValueListenableBuilder<String?>(
                                    valueListenable:
                                        viewModel.noteTextField.valueNotifier,
                                    builder: (context, noteText, child) {
                                      return ValueListenableBuilder<TextAlign>(
                                        valueListenable:
                                            viewModel.noteTextAlign,
                                        builder: (context, viewModelTextAlign,
                                            child) {
                                          return TextFormField(
                                            initialValue: noteText,
                                            onChanged: viewModel
                                                .noteTextField.onChange,
                                            style: const TextStyle(
                                              color: Color(0xFF79747E),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: viewModelTextAlign,
                                            maxLines: null,
                                            decoration: InputDecoration(
                                              hintText: l18n.strings.notePage
                                                  .noteTextLabelModal,
                                              border: InputBorder.none,
                                            ),
                                            keyboardType:
                                                TextInputType.multiline,
                                            textInputAction:
                                                TextInputAction.newline,
                                          );
                                        },
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
                    if (isKeyboardVisible)
                      Positioned(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        left: 0,
                        right: 0,
                        child: BottomSheetWidget(
                          viewModel: viewModel,
                          isKeyboardVisible: isKeyboardVisible,
                        ),
                      ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
