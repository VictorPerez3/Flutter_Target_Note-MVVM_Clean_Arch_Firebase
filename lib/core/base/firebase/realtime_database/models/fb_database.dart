import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_project_target/core/resources/note/domain/exceptions/note_not_found.exception.dart';

import '../../../dal/data/error_data.dart';
import '../../../mixins/l18n_mixin.dart';
import '../../../../resources/note/domain/constants/note_errors.constants.dart';
import '../fb_database_provider.dart';

class FbDatabaseImpl with l18nMixin implements FbDatabaseProvider {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  Future<void> saveNote({
    required String path,
    required Map<String, dynamic> noteJson,
  }) async {
    final response = await _database.ref(path).set(noteJson);
    return response;
  }

  @override
  Future<void> editNote({
    required String path,
    required Map<String, dynamic> noteJson,
  }) async {
    final response = await _database.ref(path).update(noteJson);
    return response;
  }

  @override
  Future<Map<String, dynamic>?> getNote(String path) async {
    final snapshot = await _database.ref(path).get();
    if (snapshot.exists) {
      final note = Map<String, dynamic>.from(snapshot.value as Map);
      note['id'] = snapshot.key;
      return note;
    } else {
      throw NoteNotFoundException(
          failure: ErrorData(
              message: l18n.strings.noteError.noteIdNotFoundMessage,
              id: NoteErrorsConstants.noteIdNotFoundId));
    }
  }

  @override
  Future<void> deleteNote(String path) async {
    final ref = _database.ref(path);
    final snapshot = await ref.get();
    if (snapshot.exists) {
      await ref.remove();
    } else {
      throw NoteNotFoundException(
          failure: ErrorData(
              message: l18n.strings.noteError.noteIdNotFoundMessage,
              id: NoteErrorsConstants.noteIdNotFoundId));
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllNotes(String path) async {
    final snapshot = await _database.ref(path).get();
    if (snapshot.exists) {
      final notes = <Map<String, dynamic>>[];
      final data = snapshot.value as Map<dynamic, dynamic>;

      data.forEach((key, value) {
        final note = Map<String, dynamic>.from(value);
        note['id'] = key;
        notes.add(note);
      });

      return notes;
    } else {
      return [];
    }
  }

  @override
  String? generateId() {
    return _database.ref().push().key;
  }
}
