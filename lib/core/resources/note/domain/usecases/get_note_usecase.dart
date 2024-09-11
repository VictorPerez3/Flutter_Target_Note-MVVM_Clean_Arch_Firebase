import '../../../../base/utils/encrypt_util.dart';
import '../../../auth/dal/auth_repository.dart';
import '../../dal/data/note.data.dart';
import '../../dal/datasource/firebase_realtime_database/fb_database_provider.dart';
import '../entities/note.entity.dart';

class GetNoteUsecase {
  final FbDatabaseProvider firebaseDatabase;
  final AuthRepository authRepository;

  const GetNoteUsecase(
      {required this.firebaseDatabase, required this.authRepository});

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
}
