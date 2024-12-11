import '../../../../base/utils/encrypt_util.dart';
import '../../../auth/dal/auth_repository.dart';
import '../../dal/data/note_data.dart';
import '../../dal/datasource/firebase_realtime_database/fb_database_provider.dart';
import '../entities/note_entity.dart';

class GetNoteByNoteIdUseCase {
  final FbDatabaseProvider firebaseDatabase;
  final AuthRepository authRepository;

  const GetNoteByNoteIdUseCase(
      {required this.firebaseDatabase, required this.authRepository});

  Future<Note?> getNoteByNoteId(
      {required String noteId, required String noteType}) async {
    final userId = await authRepository.getUserId();

    final noteData =
        await firebaseDatabase.getNote(userId: userId, noteId: noteId);

    final note = NoteData.fromJson(noteData!);
    final decryptedTitle = EncryptionUtil.decryptData(note.title);
    final decryptedNoteText = EncryptionUtil.decryptData(note.noteText);
    final decryptedNoteType = EncryptionUtil.decryptData(note.noteType);

    return Note(
        noteType: decryptedNoteType,
        id: note.id,
        title: decryptedTitle,
        noteText: decryptedNoteText,
        hide: note.hide,
        updatedAt: note.updatedAt,
        backgroundColor: note.backgroundColor,
        alignmentText: note.alignmentText);
  }
}
