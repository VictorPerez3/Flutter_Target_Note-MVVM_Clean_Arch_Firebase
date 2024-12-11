import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_project_target/core/resources/note/domain/exceptions/note_not_found_exception.dart';

import '../../../../../base/dal/data/error_data.dart';
import '../../../../../base/mixins/l18n_mixin.dart';
import '../../../domain/constants/note_errors_constants.dart';
import '../../../domain/exceptions/operation_note_fail_exception.dart';
import '../../../domain/exceptions/operation_user_info_exception.dart';
import '../../data/note_data.dart';
import '../../dto/save_note_body.dart';
import '../../dto/save_note_response.dart';
import 'fb_database_provider.dart';

class FbDatabase with l18nMixin implements FbDatabaseProvider {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  Future<SaveNoteResponse> saveNote({
    required String userId,
    required SaveNoteBody body,
  }) async {
    try {
      final newIdNote = generateId() ?? '';
      await _database.ref('$userId/notes/$newIdNote').set(body.toJson());
      return SaveNoteResponse(
        data: SaveNoteDataResponse(
          noteData: NoteData(
              id: newIdNote,
              noteType: body.noteType,
              title: body.title,
              noteText: body.noteText,
              hide: body.hide,
              updatedAt: body.updatedAt,
              backgroundColor: body.backgroundColor,
              alignmentText: body.alignmentText),
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
    required String noteId,
    required SaveNoteBody body,
  }) async {
    try {
      await _database.ref('$userId/notes/$noteId').update(body.toJson());
      return SaveNoteResponse(
        data: SaveNoteDataResponse(
          noteData: NoteData(
              id: noteId,
              noteType: body.noteType,
              title: body.title,
              noteText: body.noteText,
              hide: body.hide,
              updatedAt: body.updatedAt,
              backgroundColor: body.backgroundColor,
              alignmentText: body.alignmentText),
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
      {required String userId, required String noteId}) async {
    try {
      final snapshot = await _database.ref('$userId/notes/$noteId').get();
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
      {required String userId, required String noteId}) async {
    try {
      final ref = _database.ref('$userId/notes/$noteId');
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
  Future<List<Map<String, dynamic>>> getUnhiddenNotesByNoteType({
    required String userId,
    required String noteType,
  }) async {
    try {
      final snapshot = await _database.ref('$userId/notes').get();
      if (snapshot.exists) {
        final notes = <Map<String, dynamic>>[];
        final data = snapshot.value as Map<dynamic, dynamic>;

        data.forEach((key, value) {
          final note = Map<String, dynamic>.from(value);
          note['id'] = key;

          if (note['noteType'] == noteType && note['hide'] == false) {
            notes.add(note);
          }
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
  Future<List<Map<String, dynamic>>> getAllHiddenNotes(
      {required String userId}) async {
    try {
      final snapshot = await _database.ref('$userId/notes').get();
      if (snapshot.exists) {
        final notes = <Map<String, dynamic>>[];
        final data = snapshot.value as Map<dynamic, dynamic>;

        data.forEach((key, value) {
          final note = Map<String, dynamic>.from(value);
          note['id'] = key;

          if (note['hide'] == true) {
            notes.add(note);
          }
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
  Future<String> saveUserInfoName({
    required String userId,
    required String userInfoName,
  }) async {
    try {
      await _database.ref('$userId/userInfo/name').set(userInfoName);
      return userInfoName;
    } on Exception catch (e) {
      throw OperationUserInfoException(
          failure: ErrorData(
              message: e.toString(),
              id: NoteErrorsConstants.saveUserInfoNameId));
    }
  }

  @override
  Future<String> getUserInfoName({required String userId}) async {
    try {
      final snapshot = await _database.ref('$userId/userInfo/name').get();
      final userInfoName = snapshot.value?.toString() ?? '';
      return userInfoName;
    } catch (e) {
      throw OperationUserInfoException(
        failure: ErrorData(
          message: e.toString(),
          id: NoteErrorsConstants.getUserInfoNameId,
        ),
      );
    }
  }

  @override
  String? generateId() {
    return _database.ref().push().key;
  }
}
