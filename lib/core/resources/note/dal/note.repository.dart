import 'package:flutter_project_target/core/resources/note/dal/data/note.data.dart';
import 'package:flutter_project_target/core/resources/note/dal/dto/save_note.body.dart';
import 'package:flutter_project_target/core/resources/note/domain/entities/note.entity.dart';

import '../../../base/dal/data/error_data.dart';
import '../../../base/dal/storage/storage_interface.dart';
import '../../../base/mixins/l18n_mixin.dart';
import '../../../base/utils/encrypt_util.dart';
import '../../auth/domain/constants/auth_storage_constants.dart';
import '../domain/constants/note_errors.constants.dart';
import '../domain/exceptions/userid_not_found.exception.dart';
import 'datasource/note.datasource.interface.dart';
import 'mappers/note.mapper.dart';

class NoteRepository with l18nMixin {
  final INoteDataSource noteDataSource;
  final IStorage storage;

  const NoteRepository({required this.noteDataSource, required this.storage});

  Future<String> _getUserId() async {
    final user =
        await storage.read<Map<String, dynamic>>(AuthStorageConstants.user);
    if (user != null && user.containsKey('id')) {
      return user['id'] as String;
    } else {
      throw UseridNotFoundException(
          failure: ErrorData(
              message: l18n.strings.noteError.useridNotFoundMessage,
              id: NoteErrorsConstants.useridNotFoundId));
    }
  }

  Future<Note> saveNote({
    required String noteType,
    required String title,
    required String noteText,
  }) async {
    final noteTextEncrypt = EncryptionUtil.encryptData(noteText);
    final titleEncrypt = EncryptionUtil.encryptData(title);
    final body = SaveNoteBody(title: titleEncrypt, noteText: noteTextEncrypt);
    final userId = await _getUserId();
    final response = await noteDataSource.saveNote(
        body: body, userId: userId, noteType: noteType);
    final savedNote = NoteMapper.toModel(response.data!.noteData);
    return savedNote;
  }

  Future<Note> editNote({
    required String noteId,
    required String noteType,
    required String title,
    required String noteText,
  }) async {
    final noteTextEncrypt = EncryptionUtil.encryptData(noteText);
    final titleEncrypt = EncryptionUtil.encryptData(title);
    final body = SaveNoteBody(title: titleEncrypt, noteText: noteTextEncrypt);
    final userId = await _getUserId();
    final response = await noteDataSource.editNote(
        body: body, userId: userId, noteId: noteId, noteType: noteType);
    final editedNote = NoteMapper.toModel(response.data!.noteData);
    return editedNote;
  }

  Future<void> deleteNote(
      {required String noteId, required String noteType}) async {
    final userId = await _getUserId();
    await noteDataSource.deleteNote(
        userId: userId, noteId: noteId, noteType: noteType);
  }

  Future<Note?> getNote(
      {required String noteId, required String noteType}) async {
    final userId = await _getUserId();
    final noteData = await noteDataSource.getNote(
        userId: userId, noteId: noteId, noteType: noteType);

    final note = NoteData.fromJson(noteData!);
    final decryptedTitle = EncryptionUtil.decryptData(note.title);
    final decryptedNoteText = EncryptionUtil.decryptData(note.noteText);

    return Note(
      id: note.id,
      title: decryptedTitle,
      noteText: decryptedNoteText,
    );
  }

  Future<List<Note>> getAllNotes({required String noteType}) async {
    final userId = await _getUserId();
    final notes = <Note>[];
    final notesData =
        await noteDataSource.getAllNotes(userId: userId, noteType: noteType);

    for (var noteJson in notesData) {
      final noteData = NoteData.fromJson(noteJson);
      final decryptedTitle = EncryptionUtil.decryptData(noteData.title);
      final decryptedNoteText = EncryptionUtil.decryptData(noteData.noteText);

      notes.add(Note(
        id: noteData.id,
        title: decryptedTitle,
        noteText: decryptedNoteText,
      ));
    }
    return notes;
  }
}
