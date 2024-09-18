import '../../../../base/utils/encrypt_util.dart';
import '../../../auth/dal/auth_repository.dart';
import '../../dal/data/note.data.dart';
import '../../dal/datasource/firebase_realtime_database/fb_database_provider.dart';
import '../entities/note.entity.dart';

class GetAllNotesUsecase {
  final FbDatabaseProvider firebaseDatabase;
  final AuthRepository authRepository;

  const GetAllNotesUsecase(
      {required this.firebaseDatabase, required this.authRepository});

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
      final decryptedHashtags = EncryptionUtil.decryptList(noteData.hashtags);
      final updatedAt = noteData.updatedAt;

      notes.add(Note(
          id: noteData.id,
          title: decryptedTitle,
          noteText: decryptedNoteText,
          hashtags: decryptedHashtags,
          updatedAt: updatedAt));
    }
    return notes;
  }
}
