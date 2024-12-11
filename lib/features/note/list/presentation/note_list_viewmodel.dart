import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_project_target/core/resources/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_project_target/core/resources/note/domain/usecases/get_unhidden_notes_by_notetype_usecase.dart';

import '../../../../core/base/abstractions/field_interface.dart';
import '../../../../core/base/abstractions/viewmodel_interface.dart';
import '../../../../core/resources/note/domain/constants/note_types_and_hide_constants.dart';
import '../../../../core/resources/note/domain/entities/note_entity.dart';
import '../../../../core/resources/note/domain/usecases/delete_note_usecase.dart';
import '../../../../core/resources/note/domain/usecases/edit_note_usecase.dart';
import '../../../../core/resources/note/domain/usecases/get_all_hidden_notes_usecase.dart';
import '../../../../core/resources/note/domain/usecases/get_user_info_name_usecase.dart';
import '../../../../core/resources/note/domain/usecases/save_note_usecase.dart';

class NoteListViewModel extends IViewModel {
  final DeleteNoteUseCase deleteNoteUsecase;
  final GetUnhiddenNotesByNoteTypeUseCase getUnhiddenNotesByNoteTypeUseCase;
  final GetAllHiddenNotesUseCase getAllHiddenNotesUseCase;
  final LogoutUsecase logoutUsecase;
  final GetUserInfoNameUsecase getUserInfoNameUsecase;
  final SaveNoteUseCase saveNoteUsecase;
  final EditNoteUseCase editNoteUsecase;

  final IField<String> titleField;
  final IField<String> noteTextField;
  final IField<String> userInfoNameTextField;

  ValueNotifier<List<Note>> notes = ValueNotifier<List<Note>>([]);
  ValueNotifier<String> noteTypeMode =
      ValueNotifier<String>(NoteTypesAndHideConstants.generalNotes);

  ValueNotifier<bool> menuVisible = ValueNotifier<bool>(false);
  ValueNotifier<Offset?> menuPosition = ValueNotifier<Offset?>(null);
  ValueNotifier<Note?> selectedNoteForMenu = ValueNotifier<Note?>(null);

  static const double menuHeight = 184.0;

  NoteListViewModel({
    required this.titleField,
    required this.noteTextField,
    required this.userInfoNameTextField,
    required this.deleteNoteUsecase,
    required this.getUnhiddenNotesByNoteTypeUseCase,
    required this.getAllHiddenNotesUseCase,
    required this.logoutUsecase,
    required this.getUserInfoNameUsecase,
    required this.saveNoteUsecase,
    required this.editNoteUsecase,
  }) {
    _loadPage();
    noteTypeMode.addListener(_loadPage);
  }

  Future<void> logout() async {
    try {
      loading.isLoading = true;
      await logoutUsecase.logout();
    } finally {
      loading.isLoading = false;
    }
  }

  Future<void> removeNote(String noteId) async {
    await deleteNoteUsecase.deleteNote(noteId: noteId);
    await _loadPage();
  }

  Future<void> _loadPage() async {
    try {
      menuVisible.value = false;
      loading.isLoading = true;
      if (noteTypeMode.value != NoteTypesAndHideConstants.hiddenNotes) {
        final allUnhiddenNotesByNoteType =
            await getUnhiddenNotesByNoteTypeUseCase.getUnhiddenNotesByNoteType(
                noteType: noteTypeMode.value);
        notes.value = allUnhiddenNotesByNoteType;
      } else {
        final allHiddenNotes =
            await getAllHiddenNotesUseCase.getAllHiddenNotes();
        notes.value = allHiddenNotes;
      }
      userInfoNameTextField.valueNotifier.value =
          await getUserInfoNameUsecase.getUserInfoName();
    } finally {
      loading.isLoading = false;
    }
  }

  String getDisplayTextByNoteType(Note note) {
    switch (noteTypeMode.value) {
      case NoteTypesAndHideConstants.personalAccounts:
      case NoteTypesAndHideConstants.bankNotes:
      case NoteTypesAndHideConstants.hiddenNotes:
        return '#####';
      case NoteTypesAndHideConstants.generalNotes:
      default:
        return note.noteText;
    }
  }

  List<List<Note>> getNotesInColumns(List<Note> notes, int numColumns) {
    List<List<Note>> columns = List.generate(numColumns, (_) => []);
    for (int i = 0; i < notes.length; i++) {
      columns[i % numColumns].add(notes[i]);
    }
    return columns;
  }

  Offset calculateMenuPosition({
    required Offset itemOffset,
    required Size itemSize,
    required double screenHeight,
  }) {
    final itemLeft = itemOffset.dx;
    const itemBottomHeightRepair = -85.0;
    final itemBottom = itemOffset.dy + itemSize.height + itemBottomHeightRepair;

    final availableSpaceBelowItemList =
        screenHeight - itemOffset.dy - itemSize.height;

    Offset menuPosition;
    if (availableSpaceBelowItemList < menuHeight) {
      const itemTopHeightRepair = -90.0;
      final itemTop = itemOffset.dy + itemTopHeightRepair;
      menuPosition = Offset(itemLeft, itemTop - menuHeight);
    } else {
      menuPosition = Offset(itemLeft, itemBottom);
    }

    return menuPosition;
  }

  void showMenuForNote(Note note, Offset itemBottomOffset, Size noteItemSize) {
    selectedNoteForMenu.value = note;
    menuPosition.value = itemBottomOffset;
    menuVisible.value = true;
  }

  void hideMenu() {
    menuVisible.value = false;
    selectedNoteForMenu.value = null;
    menuPosition.value = null;
  }

  Future<void> deleteSelectedNote() async {
    final note = selectedNoteForMenu.value;
    if (note == null) return;
    await removeNote(note.id);
    hideMenu();
  }

  Future<void> duplicateSelectedNote() async {
    final note = selectedNoteForMenu.value;
    if (note == null) {
      hideMenu();
      return;
    }
    await saveNoteUsecase.saveNote(
      noteType: note.noteType,
      title: note.title,
      noteText: note.noteText,
      hide: note.hide,
      backgroundColor: note.backgroundColor,
      alignmentText: note.alignmentText,
    );
    await _loadPage();
    hideMenu();
  }

  Future<void> hideSelectedNote({required bool hide}) async {
    final note = selectedNoteForMenu.value;
    if (note == null) {
      hideMenu();
      return;
    }

    await editNoteUsecase.editNote(
      noteId: note.id,
      noteType: note.noteType,
      title: note.title,
      noteText: note.noteText,
      hide: hide,
      backgroundColor: note.backgroundColor,
      alignmentText: note.alignmentText,
    );
    await _loadPage();
    hideMenu();
  }

  @override
  void dispose() {
    titleField.dispose();
    noteTextField.dispose();
    userInfoNameTextField.dispose();
  }
}
