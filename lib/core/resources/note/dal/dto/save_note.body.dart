import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'save_note.body.g.dart';

@JsonSerializable()
class SaveNoteBody extends Equatable {
  final String title;
  final String noteText;
  final List<String> hashtags;
  final DateTime updatedAt;

  SaveNoteBody(
      {required String title,
      required String noteText,
      required List<String> hashtags,
      required this.updatedAt})
      : title = title.trim(),
        noteText = noteText.trim(),
        hashtags = hashtags.map((tag) => tag.trim()).toList();

  factory SaveNoteBody.fromJson(Map<String, dynamic> json) =>
      _$SaveNoteBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SaveNoteBodyToJson(this);

  bool get isValid => _isTitleValid && _isNoteTextValid && _areHashtagsValid;

  bool get _isTitleValid {
    return title.isNotEmpty;
  }

  bool get _isNoteTextValid {
    return noteText.isNotEmpty;
  }

  bool get _areHashtagsValid {
    return hashtags.isNotEmpty && hashtags.every((tag) => tag.isNotEmpty);
  }

  @override
  List<Object?> get props => [title, noteText, hashtags, updatedAt];
}
