import 'package:flutter/material.dart';
import 'package:flutter_project_target/features/note/list/presentation/tag/note_list_tag.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/base/abstractions/custom_exception_interface.dart';
import '../../../../core/base/mixins/analytics_mixin.dart';
import '../../../../core/base/mixins/l18n_mixin.dart';
import '../../../../core/base/mixins/viewmodel_mixin.dart';
import '../../../../core/base/utils/snackbar_util.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/resources/note/domain/constants/note_types_and_hide_constants.dart';
import '../../../../core/resources/note/domain/entities/note_entity.dart';
import '../../../shared/loading/loading_widget.dart';
import '../../../shared/widgets/note/add_button_widget.dart';
import '../../../shared/widgets/note/menu_item_list_widget.dart';
import '../../../shared/widgets/note/note_list_bar_widget.dart';
import '../../../shared/widgets/note/note_list_widget.dart';
import '../../../shared/widgets/note/note_types_button_widget.dart';
import 'note_list_viewmodel.dart';

class NoteListScreen extends StatelessWidget
    with
        ViewModelMixin<NoteListViewModel>,
        AnalyticsMixin<NoteListTag>,
        l18nMixin {
  final String? initialNoteTypeMode;

  const NoteListScreen({super.key, this.initialNoteTypeMode});

  void logout(BuildContext context) async {
    try {
      FocusScope.of(context).unfocus();
      await tag.onLogoutEvent("Logout");
      viewModel.logout();
      if (context.mounted) {
        context.goNamed(Routes.signIn);
      }
    } on CustomException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    }
  }

  void _goNoteDetails({Note? note, required BuildContext context}) async {
    try {
      FocusScope.of(context).unfocus();
      await tag.onListToDetailEvent("List screen to Details Screen");
      if (context.mounted) {
        context.goNamed(
          Routes.noteDetails,
          extra: {
            'note': note,
            'noteTypeMode': viewModel.noteTypeMode.value,
          },
        );
      }
    } on CustomException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    }
  }

  Future<void> handleDeleteNote(BuildContext context) async {
    try {
      await viewModel.deleteSelectedNote();
      await tag.onDeleteNoteEvent("Note Deleted");
    } on CustomException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    }
  }

  Future<void> handleDuplicateNote(BuildContext context) async {
    try {
      viewModel.duplicateSelectedNote();
      await tag.onDuplicateNoteEvent("Duplicate Note");
    } on CustomException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    }
  }

  Future<void> handleHiddenNote(BuildContext context) async {
    try {
      viewModel.hideSelectedNote(hide: true);
      await tag.onHideNoteEvent("Hidden Note");
    } on CustomException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    }
  }

  Future<void> handleUnhiddenNote(BuildContext context) async {
    try {
      viewModel.hideSelectedNote(hide: false);
      await tag.onUnhideNoteEvent("Unhidden Note");
    } on CustomException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (initialNoteTypeMode != null) {
      viewModel.noteTypeMode.value = initialNoteTypeMode!;
    }

    return LoadingWidget(
      child: ValueListenableBuilder<String?>(
        valueListenable: viewModel.userInfoNameTextField.valueNotifier,
        builder: (context, userName, _) {
          final userInfoText =
              '${l18n.strings.notePage.titleUserInfoNameLabel} $userName';

          return Scaffold(
            appBar: NoteListBar(
              titleUserInfoName: userInfoText,
              onLogout: () => logout(context),
            ),
            body: GestureDetector(
              onTap: () {
                if (viewModel.menuVisible.value) {
                  viewModel.hideMenu();
                }
              },
              behavior: HitTestBehavior.opaque,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(color: Color(0xFF1C1B1F)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l18n.strings.notePage.titleScreenLabel,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.25,
                              color: Color(0xFFFFFBFE),
                            ),
                          ),
                          NoteTypesButton(
                            noteTypeMode: viewModel.noteTypeMode,
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFF1C1B1F),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: ValueListenableBuilder<List<Note>>(
                                valueListenable: viewModel.notes,
                                builder: (context, notes, child) {
                                  return NoteList(
                                    notes: notes,
                                    controller: viewModel,
                                    goNoteDetails: _goNoteDetails,
                                    onShowMenu: (Note note, Offset globalPos,
                                        Size size) {
                                      viewModel.showMenuForNote(
                                          note, globalPos, size);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  ValueListenableBuilder<String>(
                    valueListenable: viewModel.noteTypeMode,
                    builder: (context, noteTypeModeValue, child) {
                      if (noteTypeModeValue ==
                          NoteTypesAndHideConstants.hiddenNotes) {
                        return const SizedBox.shrink();
                      } else {
                        return AddButton(
                          onTap: () {
                            viewModel.hideMenu();
                            _goNoteDetails(context: context, note: null);
                          },
                        );
                      }
                    },
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: viewModel.menuVisible,
                    builder: (context, visible, _) {
                      if (!visible) return const SizedBox.shrink();
                      return ValueListenableBuilder<Offset?>(
                        valueListenable: viewModel.menuPosition,
                        builder: (context, position, __) {
                          if (position == null) return const SizedBox.shrink();
                          return Positioned(
                            left: position.dx,
                            top: position.dy,
                            child: GestureDetector(
                              onTap: () {},
                              child: MenuItemList(
                                onDelete: () {
                                  handleDeleteNote(context);
                                  viewModel.hideMenu();
                                },
                                onDuplicate: () {
                                  handleDuplicateNote(context);
                                  viewModel.hideMenu();
                                },
                                onHide: () {
                                  handleHiddenNote(context);
                                  viewModel.hideMenu();
                                },
                                onUnhide: () {
                                  handleUnhiddenNote(context);
                                  viewModel.hideMenu();
                                },
                                noteTypeMode: viewModel.noteTypeMode.value,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
