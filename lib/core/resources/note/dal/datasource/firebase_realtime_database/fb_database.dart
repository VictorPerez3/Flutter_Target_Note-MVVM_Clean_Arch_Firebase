import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_project_target/core/resources/note/domain/exceptions/note_not_found.exception.dart';

import '../../../../../base/dal/data/error_data.dart';
import '../../../../../base/mixins/l18n_mixin.dart';
import '../../../domain/constants/note_errors.constants.dart';
import '../../../domain/exceptions/operation_note_fail.exception.dart';
import '../../data/note.data.dart';
import '../../dto/save_note.body.dart';
import '../../dto/save_note.response.dart';
import 'fb_database_provider.dart';

class FbDatabase with l18nMixin implements FbDatabaseProvider {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  Future<SaveNoteResponse> saveNote({
    required String userId,
    required String noteType,
    required SaveNoteBody body,
  }) async {
    try {
      final newIdNote = generateId() ?? '';
      await _database
          .ref('noteType/$noteType/$userId/$newIdNote')
          .set(body.toJson());
      return SaveNoteResponse(
        data: SaveNoteDataResponse(
          noteData: NoteData(
              id: newIdNote, title: body.title, noteText: body.noteText),
        ),
        errors: null,
      );
    } on Exception catch (e) {
      throw OperationNoteFailException(
          failure: ErrorData(
              message: e.toString(), id: NoteErrorsConstants.saveNoteFailId));
    }
  }

  @override
  Future<SaveNoteResponse> editNote({
    required String userId,
    required String noteType,
    required String noteId,
    required SaveNoteBody body,
  }) async {
    try {
      await _database
          .ref('noteType/$noteType/$userId/$noteId')
          .update(body.toJson());
      return SaveNoteResponse(
        data: SaveNoteDataResponse(
          noteData:
              NoteData(id: noteId, title: body.title, noteText: body.noteText),
        ),
        errors: null,
      );
    } on Exception catch (e) {
      throw OperationNoteFailException(
          failure: ErrorData(
              message: e.toString(), id: NoteErrorsConstants.editNoteFailId));
    }
  }

  @override
  Future<Map<String, dynamic>?> getNote(
      {required String userId,
      required String noteType,
      required String noteId}) async {
    try {
      final snapshot =
          await _database.ref('noteType/$noteType/$userId/$noteId').get();
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
    } catch (e) {
      throw OperationNoteFailException(
          failure: ErrorData(
              message: e.toString(), id: NoteErrorsConstants.getNoteFailId));
    }
  }

  @override
  Future<void> deleteNote(
      {required String userId,
      required String noteType,
      required String noteId}) async {
    try {
      final ref = _database.ref('noteType/$noteType/$userId/$noteId');
      final snapshot = await ref.get();
      if (snapshot.exists) {
        await ref.remove();
      } else {
        throw NoteNotFoundException(
            failure: ErrorData(
                message: l18n.strings.noteError.noteIdNotFoundMessage,
                id: NoteErrorsConstants.noteIdNotFoundId));
      }
    } catch (e) {
      throw OperationNoteFailException(
          failure: ErrorData(
              message: e.toString(), id: NoteErrorsConstants.deleteNoteFailId));
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllNotes(
      {required String noteType, required String userId}) async {
    try {
      final snapshot = await _database.ref('noteType/$noteType/$userId').get();
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
    } catch (e) {
      throw OperationNoteFailException(
          failure: ErrorData(
              message: e.toString(), id: NoteErrorsConstants.getAllNoteFailId));
    }
  }

  @override
  String? generateId() {
    return _database.ref().push().key;
  }
}
