import '../../../../base/utils/encrypt_util.dart';
import '../../../auth/dal/auth_repository.dart';
import '../../dal/data/note.data.dart';
import '../../dal/datasource/firebase_realtime_database/fb_database_provider.dart';
import '../../dal/dto/save_note.body.dart';
import '../../dal/mappers/note.mapper.dart';
import '../entities/note.entity.dart';

class NoteUsecase {
  final FbDatabaseProvider firebaseDatabase;
  final AuthRepository authRepository;

  const NoteUsecase(
      {required this.firebaseDatabase, required this.authRepository});

  Future<Note> saveNote({
    required String noteType,
    required String title,
    required String noteText,
  }) async {
    final noteTextEncrypt = EncryptionUtil.encryptData(noteText);
    final titleEncrypt = EncryptionUtil.encryptData(title);
    final body = SaveNoteBody(title: titleEncrypt, noteText: noteTextEncrypt);
    final userId = await authRepository.getUserId();

    final response = await firebaseDatabase.saveNote(
        body: body, userId: userId, noteType: noteType);

    final savedNote = NoteMapper.toModel(response.data!.noteData);
    return savedNote;
  }

  Future<void> logout() {
    return authRepository.clearUserData();
  }

  Future<Note> editNote({
    required String noteId,
    required String noteType,
    required String title,
    required String noteText,
  }) async {
    final noteTextEncrypt = EncryptionUtil.encryptData(noteText);
    final titleEncrypt = EncryptionUtil.encryptData(title);
    final body = SaveNoteBody(title: titleEncrypt, noteText: noteTextEncrypt);
    final userId = await authRepository.getUserId();

    final response = await firebaseDatabase.editNote(
        body: body, userId: userId, noteId: noteId, noteType: noteType);

    final editedNote = NoteMapper.toModel(response.data!.noteData);
    return editedNote;
  }

  Future<void> deleteNote(
      {required String noteId, required String noteType}) async {
    final userId = await authRepository.getUserId();

    await firebaseDatabase.deleteNote(
        userId: userId, noteId: noteId, noteType: noteType);
  }

  Future<Note?> getNote(
      {required String noteId, required String noteType}) async {
    final userId = await authRepository.getUserId();

    final noteData = await firebaseDatabase.getNote(
        userId: userId, noteId: noteId, noteType: noteType);

    final note = NoteData.fromJson(noteData!);
    final decryptedTitle = EncryptionUtil.decryptData(note.title);
    final decryptedNoteText = EncryptionUtil.decryptData(note.noteText);

    return Note(
      id: note.id,
      title: decryptedTitle,
      noteText: decryptedNoteText,
    );
  }

  Future<List<Note>> getAllNotes({
    required String noteType,
  }) async {
    final userId = await authRepository.getUserId();
    final notes = <Note>[];

    final notesData =
        await firebaseDatabase.getAllNotes(userId: userId, noteType: noteType);

    for (var noteJson in notesData) {
      final noteData = NoteData.fromJson(noteJson);
      final decryptedTitle = EncryptionUtil.decryptData(noteData.title);
      final decryptedNoteText = EncryptionUtil.decryptData(noteData.noteText);

      notes.add(Note(
        id: noteData.id,
        title: decryptedTitle,
        noteText: decryptedNoteText,
      ));
    }
    return notes;
  }
}
