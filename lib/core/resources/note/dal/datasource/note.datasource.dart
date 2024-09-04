import 'package:flutter_project_target/core/resources/note/dal/datasource/note.datasource.interface.dart';
import 'package:flutter_project_target/core/resources/note/domain/constants/note_errors.constants.dart';

import '../../../../base/dal/data/error_data.dart';
import '../../../../base/firebase/realtime_database/fb_database_provider.dart';
import '../../domain/exceptions/operation_note_fail.exception.dart';
import '../data/note.data.dart';
import '../dto/save_note.body.dart';
import '../dto/save_note.response.dart';

class NoteDataSource implements INoteDataSource {
  final FbDatabaseProvider _firebaseDatabase;

  NoteDataSource(this._firebaseDatabase);

  @override
  Future<SaveNoteResponse> saveNote({
    required String userId,
    required String noteType,
    required SaveNoteBody body,
  }) async {
    try {
      final newIdNote = _firebaseDatabase.generateId() ?? '';
      await _firebaseDatabase.saveNote(
        path: 'noteType/$noteType/$userId/$newIdNote',
        noteJson: body.toJson(),
      );
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
      await _firebaseDatabase.editNote(
        path: 'noteType/$noteType/$userId/$noteId',
        noteJson: body.toJson(),
      );
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
  Future<void> deleteNote(
      {required String userId,
      required String noteType,
      required String noteId}) async {
    try {
      await _firebaseDatabase.deleteNote('noteType/$noteType/$userId/$noteId');
    } catch (e) {
      throw OperationNoteFailException(
          failure: ErrorData(
              message: e.toString(), id: NoteErrorsConstants.deleteNoteFailId));
    }
  }

  @override
  Future<Map<String, dynamic>?> getNote(
      {required String userId,
      required String noteType,
      required String noteId}) async {
    try {
      final noteData =
          await _firebaseDatabase.getNote('noteType/$noteType/$userId/$noteId');
      return noteData;
    } catch (e) {
      throw OperationNoteFailException(
          failure: ErrorData(
              message: e.toString(), id: NoteErrorsConstants.getNoteFailId));
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllNotes(
      {required String noteType, required String userId}) async {
    try {
      final notesData =
          await _firebaseDatabase.getAllNotes('noteType/$noteType/$userId');
      return notesData;
    } catch (e) {
      throw OperationNoteFailException(
          failure: ErrorData(
              message: e.toString(), id: NoteErrorsConstants.getAllNoteFailId));
    }
  }
}
