import 'package:flutter/material.dart';
import 'package:flutter_project_target/features/note/list/presentation/tag/note_list_tag.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/base/abstractions/custom_exception_interface.dart';
import '../../../../core/base/constants/general_string.dart';
import '../../../../core/base/mixins/analytics_mixin.dart';
import '../../../../core/base/mixins/l18n_mixin.dart';
import '../../../../core/base/mixins/viewmodel_mixin.dart';
import '../../../../core/base/utils/snackbar_util.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/resources/note/domain/entities/note.entity.dart';
import '../../../shared/loading/loading_widget.dart';
import '../../../shared/widgets/general/background_box_decoration_widget.dart';
import '../../../shared/widgets/note/note_list_widget.dart';
import '../../../shared/widgets/note/segmented_button_note_widget.dart';
import 'note_list_viewmodel.dart';

class NoteListScreen extends StatelessWidget
    with
        ViewModelMixin<NoteListViewModel>,
        AnalyticsMixin<NoteListTag>,
        l18nMixin {
  const NoteListScreen({super.key});

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
        context.goNamed(Routes.noteDetails, extra: note);
      }
    } on CustomException catch (err) {
      if (context.mounted) showErrorSnackbar(context: context, err: err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Scaffold(
        appBar: buildAppBar(context),
        body: Container(
          decoration: backgroundBoxDecoration(signIn: false),
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
                          goNoteDetails: _goNoteDetails,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () =>
                        _goNoteDetails(context: context, note: null),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () => logout(context),
      ),
      title: const Text(GeneralConstants.strAppBarLabel),
      centerTitle: true,
    );
  }
}
