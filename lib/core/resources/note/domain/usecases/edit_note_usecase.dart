import 'package:flutter_project_target/core/base/utils/date_time_util.dart';

import '../../../../base/utils/encrypt_util.dart';
import '../../../auth/dal/auth_repository.dart';
import '../../dal/datasource/firebase_realtime_database/fb_database_provider.dart';
import '../../dal/dto/save_note.body.dart';
import '../../dal/mappers/note.mapper.dart';
import '../entities/note.entity.dart';

class EditNoteUsecase {
  final FbDatabaseProvider firebaseDatabase;
  final AuthRepository authRepository;

  const EditNoteUsecase(
      {required this.firebaseDatabase, required this.authRepository});

  Future<Note> editNote({
    required String noteId,
    required String noteType,
    required String title,
    required String noteText,
    required List<String> hashtags,
  }) async {
    final noteTextEncrypt = EncryptionUtil.encryptData(noteText);
    final titleEncrypt = EncryptionUtil.encryptData(title);
    final hashtagsEncrypt = EncryptionUtil.encryptList(hashtags);
    final updatedAt = DateTimeUtil.getCurrentDateTime();

    final body = SaveNoteBody(
        title: titleEncrypt,
        noteText: noteTextEncrypt,
        hashtags: hashtagsEncrypt,
        updatedAt: updatedAt);

    final userId = await authRepository.getUserId();

    final response = await firebaseDatabase.editNote(
        body: body, userId: userId, noteId: noteId, noteType: noteType);

    final editedNote = NoteMapper.toModel(response.data!.noteData);
    return editedNote;
  }
}
