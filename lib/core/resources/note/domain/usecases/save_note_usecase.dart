import '../../../../base/utils/encrypt_util.dart';
import '../../../auth/dal/auth_repository.dart';
import '../../dal/datasource/firebase_realtime_database/fb_database_provider.dart';
import '../../dal/dto/save_note.body.dart';
import '../../dal/mappers/note.mapper.dart';
import '../entities/note.entity.dart';

class SaveNoteUsecase {
  final FbDatabaseProvider firebaseDatabase;
  final AuthRepository authRepository;

  const SaveNoteUsecase(
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
}
