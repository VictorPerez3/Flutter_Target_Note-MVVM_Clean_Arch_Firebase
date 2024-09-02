import '../../../core/resources/auth/dal/auth.repository.dart';
import '../../../core/resources/note/dal/note.repository.dart';
import '../../../core/resources/note/domain/entities/note.entity.dart';

class NoteUsecase {
  final NoteRepository noteRepository;
  final AuthRepository authRepository;

  const NoteUsecase(
      {required this.noteRepository, required this.authRepository});

  Future<Note> saveNote({
    required String noteType,
    required String title,
    required String noteText,
  }) {
    final noteSaved = noteRepository.saveNote(
      title: title,
      noteText: noteText,
      noteType: noteType,
    );
    return noteSaved;
  }

  Future<void> logout() {
    return authRepository.clearData();
  }

  Future<Note> editNote({
    required String noteId,
    required String noteType,
    required String title,
    required String noteText,
  }) {
    final noteEdited = noteRepository.editNote(
      noteId: noteId,
      title: title,
      noteText: noteText,
      noteType: noteType,
    );
    return noteEdited;
  }

  Future<void> deleteNote({required String noteId, required String noteType}) {
    return noteRepository.deleteNote(noteId: noteId, noteType: noteType);
  }

  Future<Note?> getNote({required String noteId, required String noteType}) {
    final note = noteRepository.getNote(noteId: noteId, noteType: noteType);
    return note;
  }

  Future<List<Note>> getAllNotes({
    required String noteType,
  }) {
    final notes = noteRepository.getAllNotes(noteType: noteType);
    return notes;
  }
}
