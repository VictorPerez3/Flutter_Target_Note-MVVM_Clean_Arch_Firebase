import 'package:flutter/material.dart';
import 'package:flutter_project_target/features/note/details/presentation/tag/note_details_tag.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../../core/base/abstractions/custom_exception_interface.dart';
import '../../../../core/base/mixins/analytics_mixin.dart';
import '../../../../core/base/mixins/l18n_mixin.dart';
import '../../../../core/base/mixins/viewmodel_mixin.dart';
import '../../../../core/base/utils/date_time_util.dart';
import '../../../../core/base/utils/snackbar_util.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/resources/note/domain/entities/note_entity.dart';
import '../../../shared/loading/loading_widget.dart';
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
          showSuccessSnackbar(
            context: context,
            title: l18n.strings.general.sucessToast,
            message: l18n.strings.notePage.addItemToast,
          );
        },
        onEditSuccess: () {
          tag.onEditNoteEvent(l18n.strings.notePage.editItemToast);
          showSuccessSnackbar(
            context: context,
            title: l18n.strings.general.sucessToast,
            message: l18n.strings.notePage.editItemToast,
          );
        },
        onError: (err) {
          showErrorSnackbar(context: context, err: err as CustomException);
        },
      );
      tag.onDetailToListEvent("Details screen to List Screen");
      context.goNamed(Routes.noteList);
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
                                      arrowBackIcon(
                                          context: context, note: note),
                                      Text(
                                        viewModel.getNoteTypeLabel(),
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
