import '../../dto/save_note.body.dart';
import '../../dto/save_note.response.dart';

abstract class FbDatabaseProvider {

  Future<SaveNoteResponse> saveNote({
    required String userId,
    required String noteType,
    required SaveNoteBody body,
  });

  Future<SaveNoteResponse> editNote({
    required String userId,
    required String noteType,
    required String noteId,
    required SaveNoteBody body,
  });

  Future<Map<String, dynamic>?> getNote(
      {required String userId,
      required String noteType,
      required String noteId});

  Future<void> deleteNote(
      {required String userId,
      required String noteType,
      required String noteId});

  Future<List<Map<String, dynamic>>> getAllNotes(
      {required String noteType, required String userId});

  String? generateId();
}
