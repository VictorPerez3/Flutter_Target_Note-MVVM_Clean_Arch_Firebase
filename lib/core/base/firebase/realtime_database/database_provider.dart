abstract class FbDatabaseProvider {
  Future<void> saveNote({
    required String path,
    required Map<String, dynamic> noteJson,
  });

  Future<void> editNote({
    required String path,
    required Map<String, dynamic> noteJson,
  });

  Future<Map<String, dynamic>?> getNote(String path);

  Future<void> deleteNote(String path);

  Future<List<Map<String, dynamic>>> getAllNotes(String path);

  String? generateId();
}
