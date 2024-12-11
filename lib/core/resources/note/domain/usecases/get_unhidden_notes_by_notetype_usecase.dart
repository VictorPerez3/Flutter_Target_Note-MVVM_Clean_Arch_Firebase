import '../../../../base/utils/encrypt_util.dart';
import '../../../auth/dal/auth_repository.dart';
import '../../dal/data/note_data.dart';
import '../../dal/datasource/firebase_realtime_database/fb_database_provider.dart';
import '../entities/note_entity.dart';

class GetUnhiddenNotesByNoteTypeUseCase {
  final FbDatabaseProvider firebaseDatabase;
  final AuthRepository authRepository;

  const GetUnhiddenNotesByNoteTypeUseCase(
      {required this.firebaseDatabase, required this.authRepository});

  Future<List<Note>> getUnhiddenNotesByNoteType(
      {required String noteType}) async {
    final userId = await authRepository.getUserId();
    final notes = <Note>[];
    final encryptedNoteType = EncryptionUtil.encryptData(noteType);

    final notesData = await firebaseDatabase.getUnhiddenNotesByNoteType(
        userId: userId, noteType: encryptedNoteType);

    for (var noteJson in notesData) {
      final noteData = NoteData.fromJson(noteJson);
      final decryptedTitle = EncryptionUtil.decryptData(noteData.title);
      final decryptedNoteText = EncryptionUtil.decryptData(noteData.noteText);
      final decryptedNoteType = EncryptionUtil.decryptData(noteData.noteType);

      notes.add(Note(
          id: noteData.id,
          noteType: decryptedNoteType,
          title: decryptedTitle,
          noteText: decryptedNoteText,
          hide: noteData.hide,
          updatedAt: noteData.updatedAt,
          backgroundColor: noteData.backgroundColor,
          alignmentText: noteData.alignmentText));
    }
    return notes;
  }
}
