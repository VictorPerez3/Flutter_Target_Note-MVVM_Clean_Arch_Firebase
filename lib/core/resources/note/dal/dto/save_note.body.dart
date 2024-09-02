import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'save_note.body.g.dart';

@JsonSerializable()
class SaveNoteBody extends Equatable {
  final String title;
  final String noteText;

  SaveNoteBody({
    required String title,
    required String noteText,
  })  : title = title.trim(),
        noteText = noteText.trim();

  factory SaveNoteBody.fromJson(Map<String, dynamic> json) =>
      _$SaveNoteBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SaveNoteBodyToJson(this);

  bool get isValid => _isTitleValid && _isNoteTextValid;

  bool get _isTitleValid {
    return title.isNotEmpty;
  }

  bool get _isNoteTextValid {
    return noteText.isNotEmpty;
  }

  @override
  List<Object?> get props => [title, noteText];
}
