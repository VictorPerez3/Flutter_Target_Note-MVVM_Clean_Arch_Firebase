import 'package:json_annotation/json_annotation.dart';

part 'note.data.g.dart';

@JsonSerializable()
class NoteData {
  final String id;
  final String title;
  final String noteText;

  NoteData({required this.id, required this.title, required this.noteText});

  factory NoteData.fromJson(Map<String, dynamic> json) =>
      _$NoteDataFromJson(json);

  Map<String, dynamic> toJson() => _$NoteDataToJson(this);
}
