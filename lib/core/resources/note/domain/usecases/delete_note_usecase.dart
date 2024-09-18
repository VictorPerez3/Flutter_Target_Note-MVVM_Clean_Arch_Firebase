import '../../../auth/dal/auth_repository.dart';
import '../../dal/datasource/firebase_realtime_database/fb_database_provider.dart';

class DeleteNoteUsecase {
  final FbDatabaseProvider firebaseDatabase;
  final AuthRepository authRepository;

  const DeleteNoteUsecase(
      {required this.firebaseDatabase, required this.authRepository});

  Future<void> deleteNote(
      {required String noteId, required String noteType}) async {
    final userId = await authRepository.getUserId();

    await firebaseDatabase.deleteNote(
        userId: userId, noteId: noteId, noteType: noteType);
  }
}
