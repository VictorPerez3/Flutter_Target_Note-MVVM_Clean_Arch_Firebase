import '../../dto/save_note_body.dart';
import '../../dto/save_note_response.dart';

abstract class FbDatabaseProvider {
  Future<SaveNoteResponse> saveNote({
    required String userId,
    required SaveNoteBody body,
  });

  Future<SaveNoteResponse> editNote({
    required String userId,
    required String noteId,
    required SaveNoteBody body,
  });

  Future<Map<String, dynamic>?> getNote(
      {required String userId, required String noteId});

  Future<void> deleteNote({required String userId, required String noteId});

  Future<List<Map<String, dynamic>>> getUnhiddenNotesByNoteType({
    required String userId,
    required String noteType,
  });

  Future<List<Map<String, dynamic>>> getAllHiddenNotes(
      {required String userId});

  Future<String> saveUserInfoName({
    required String userId,
    required String userInfoName,
  });

  Future<String> getUserInfoName({required String userId});

  String? generateId();
}
