import 'package:flutter/foundation.dart';
import '../../../core/base/abstractions/viewmodel_interface.dart';
import '../../../core/base/abstractions/field_interface.dart';
import '../../../core/resources/note/domain/entities/note.entity.dart';
import '../binding/note_viewmodel_binding.dart';
import '../usecases/note_usecase.dart';

class NoteViewModel extends IViewModel {
  final NoteUsecase _noteUsecase;
  final IField<String> titleField;
  final IField<String> noteTextField;

  ValueNotifier<List<Note>> notes = ValueNotifier<List<Note>>([]);
  ValueNotifier<bool> isSaveButtonEnabled = ValueNotifier<bool>(false);
  ValueNotifier<String> noteTypeMode = ValueNotifier<String>("notes");

  NoteViewModel({
    required this.titleField,
    required this.noteTextField,
    required NoteUsecase noteUsecase,
  }) : _noteUsecase = noteUsecase {
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
      _noteUsecase.logout();
    } finally {
      loading.isLoading = false;
    }
  }

  Future<Note> addNote({
    required String title,
    required String noteText,
  }) async {
    final noteSaved = await _noteUsecase.saveNote(
        noteType: noteTypeMode.value, title: title, noteText: noteText);
    await _loadNotes();
    return noteSaved;
  }

  Future<void> removeNote(String noteId) async {
    await _noteUsecase.deleteNote(noteType: noteTypeMode.value, noteId: noteId);
    await _loadNotes();
  }

  Future<Note> editNote({
    required String noteId,
    required String title,
    required String noteText,
  }) async {
    final editedNote = await _noteUsecase.editNote(
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
          await _noteUsecase.getAllNotes(noteType: noteTypeMode.value);
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
    titleField.valueNotifier.removeListener(_updateSaveButtonState);
    noteTextField.valueNotifier.removeListener(_updateSaveButtonState);
  }
}
