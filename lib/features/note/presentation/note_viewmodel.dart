import 'package:flutter/foundation.dart';
import 'package:flutter_project_target/core/resources/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_project_target/core/resources/note/domain/usecases/get_all_notes_usecase.dart';
import 'package:flutter_project_target/core/resources/note/domain/usecases/get_note_usecase.dart';
import '../../../core/base/abstractions/viewmodel_interface.dart';
import '../../../core/base/abstractions/field_interface.dart';
import '../../../core/resources/note/domain/entities/note.entity.dart';
import '../../../core/resources/note/domain/usecases/delete_note_usecase.dart';
import '../../../core/resources/note/domain/usecases/edit_note_usecase.dart';
import '../../../core/resources/note/domain/usecases/save_note_usecase.dart';

class NoteViewModel extends IViewModel {
  final DeleteNoteUsecase deleteNoteUsecase;
  final EditNoteUsecase editNoteUsecase;
  final GetAllNotesUsecase getAllNotesUsecase;
  final GetNoteUsecase getNoteUsecase;
  final SaveNoteUsecase saveNoteUsecase;
  final LogoutUsecase logoutUsecase;

  final IField<String> titleField;
  final IField<String> noteTextField;

  ValueNotifier<List<Note>> notes = ValueNotifier<List<Note>>([]);
  ValueNotifier<bool> isSaveButtonEnabled = ValueNotifier<bool>(false);
  ValueNotifier<String> noteTypeMode = ValueNotifier<String>("notes");

  NoteViewModel({
    required this.titleField,
    required this.noteTextField,
    required this.deleteNoteUsecase,
    required this.editNoteUsecase,
    required this.getAllNotesUsecase,
    required this.getNoteUsecase,
    required this.saveNoteUsecase,
    required this.logoutUsecase,
  }) {
    _loadNotes();
    titleField.valueNotifier.addListener(_updateSaveButtonState);
    noteTextField.valueNotifier.addListener(_updateSaveButtonState);
    noteTypeMode.addListener(_loadNotes);
  }

  void _updateSaveButtonState() {
    isSaveButtonEnabled.value =
        (titleField.valueNotifier.value ?? '').isNotEmpty &&
            (noteTextField.valueNotifier.value ?? '').isNotEmpty;
  }

  Future<void> logout() async {
    try {
      loading.isLoading = true;
      await logoutUsecase.logout();
    } finally {
      loading.isLoading = false;
    }
  }

  Future<Note> addNote({
    required String title,
    required String noteText,
  }) async {
    final noteSaved = await saveNoteUsecase.saveNote(
        noteType: noteTypeMode.value, title: title, noteText: noteText);
    await _loadNotes();
    return noteSaved;
  }

  Future<void> removeNote(String noteId) async {
    await deleteNoteUsecase.deleteNote(
        noteType: noteTypeMode.value, noteId: noteId);
    await _loadNotes();
  }

  Future<Note> editNote({
    required String noteId,
    required String title,
    required String noteText,
  }) async {
    final editedNote = await editNoteUsecase.editNote(
        noteType: noteTypeMode.value,
        noteId: noteId,
        title: title,
        noteText: noteText);
    await _loadNotes();
    return editedNote;
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
