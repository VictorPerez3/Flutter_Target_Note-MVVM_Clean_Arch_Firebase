import 'package:flutter/foundation.dart';
import 'package:flutter_project_target/core/resources/note/domain/usecases/get_note_usecase.dart';

import '../../../../core/base/abstractions/field_interface.dart';
import '../../../../core/base/abstractions/viewmodel_interface.dart';
import '../../../../core/resources/note/domain/entities/note.entity.dart';
import '../../../../core/resources/note/domain/usecases/edit_note_usecase.dart';
import '../../../../core/resources/note/domain/usecases/save_note_usecase.dart';

class NoteDetailsViewModel extends IViewModel {
  final EditNoteUsecase editNoteUsecase;
  final GetNoteUsecase getNoteUsecase;
  final SaveNoteUsecase saveNoteUsecase;

  final IField<String> titleField;
  final IField<String> noteTextField;

  ValueNotifier<String> noteTypeMode = ValueNotifier<String>("notes");

  NoteDetailsViewModel({
    required this.titleField,
    required this.noteTextField,
    required this.editNoteUsecase,
    required this.getNoteUsecase,
    required this.saveNoteUsecase,
  });

  Future<Note> addNote({
    required String title,
    required String noteText,
    required List<String> hashtags,
  }) async {
    final noteSaved = await saveNoteUsecase.saveNote(
        noteType: noteTypeMode.value,
        title: title,
        noteText: noteText,
        hashtags: hashtags);
    return noteSaved;
  }

  Future<Note> editNote(
      {required String noteId,
      required String title,
      required String noteText,
      required List<String> hashtags}) async {
    final editedNote = await editNoteUsecase.editNote(
        noteType: noteTypeMode.value,
        noteId: noteId,
        title: title,
        noteText: noteText,
        hashtags: hashtags);
    return editedNote;
  }

  @override
  void dispose() {
    titleField.dispose();
    noteTextField.dispose();
  }
}
