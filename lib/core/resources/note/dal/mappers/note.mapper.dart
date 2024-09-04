import '../../domain/entities/note.entity.dart';
import '../data/note.data.dart';

abstract class NoteMapper {
  static Note toModel(NoteData data) {
    return Note(id: data.id, title: data.title, noteText: data.noteText);
  }

  static Map<String, dynamic> toJson(Note model) {
    return {'id': model.id, 'title': model.title, 'noteText': model.noteText};
  }
}