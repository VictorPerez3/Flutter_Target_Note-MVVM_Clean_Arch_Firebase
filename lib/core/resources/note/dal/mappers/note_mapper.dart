import '../../domain/entities/note_entity.dart';
import '../data/note_data.dart';

abstract class NoteMapper {
  static Note toModel(NoteData data) {
    return Note(
      id: data.id,
      noteType: data.noteType,
      title: data.title,
      noteText: data.noteText,
      hide: data.hide,
      updatedAt: data.updatedAt,
      backgroundColor: data.backgroundColor,
      alignmentText: data.alignmentText,
    );
  }

  static Map<String, dynamic> toJson(Note model) {
    return {
      'id': model.id,
      'noteType': model.noteType,
      'title': model.title,
      'noteText': model.noteText,
      'hide': model.hide,
      'updatedAt': model.updatedAt,
      'backgroundColor': model.backgroundColor,
      'alignmentText': model.alignmentText
    };
  }
}
