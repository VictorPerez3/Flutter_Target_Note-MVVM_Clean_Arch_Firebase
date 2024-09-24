import 'package:flutter/foundation.dart';
import 'package:flutter_project_target/core/resources/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_project_target/core/resources/note/domain/usecases/get_all_notes_usecase.dart';

import '../../../../core/base/abstractions/field_interface.dart';
import '../../../../core/base/abstractions/viewmodel_interface.dart';
import '../../../../core/resources/note/domain/entities/note_entity.dart';
import '../../../../core/resources/note/domain/usecases/delete_note_usecase.dart';

class NoteListViewModel extends IViewModel {
  final DeleteNoteUsecase deleteNoteUsecase;
  final GetAllNotesUsecase getAllNotesUsecase;
  final LogoutUsecase logoutUsecase;

  final IField<String> titleField;
  final IField<String> noteTextField;

  ValueNotifier<List<Note>> notes = ValueNotifier<List<Note>>([]);
  ValueNotifier<String> noteTypeMode = ValueNotifier<String>("notes");

  NoteListViewModel({
    required this.titleField,
    required this.noteTextField,
    required this.deleteNoteUsecase,
    required this.getAllNotesUsecase,
    required this.logoutUsecase,
  }) {
    _loadNotes();
    noteTypeMode.addListener(_loadNotes);
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
    await deleteNoteUsecase.deleteNote(
        noteType: noteTypeMode.value, noteId: noteId);
    await _loadNotes();
  }

  Future<void> _loadNotes() async {
    try {
      loading.isLoading = true;
      final allNotes =
          await getAllNotesUsecase.getAllNotes(noteType: noteTypeMode.value);
      notes.value = allNotes;
    } finally {
      loading.isLoading = false;
    }
  }

  String getDisplayText(Note note) {
    switch (noteTypeMode.value) {
      case "personal_accounts":
      case "bank_notes":
        return '#####';
      case "notes":
      default:
        return note.noteText;
    }
  }

  @override
  void dispose() {
    titleField.dispose();
    noteTextField.dispose();
  }
}
