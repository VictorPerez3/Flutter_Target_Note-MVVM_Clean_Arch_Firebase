import 'package:json_annotation/json_annotation.dart';

import '../../../../base/dal/data/error_data.dart';
import '../data/note_data.dart';

part 'save_note_response.g.dart';

@JsonSerializable()
class SaveNoteResponse {
  final SaveNoteDataResponse? data;
  final List<ErrorData>? errors;

  const SaveNoteResponse({required this.data, required this.errors})
      : assert(data != null || errors != null);

  factory SaveNoteResponse.fromJson(Map<String, dynamic> json) =>
      _$SaveNoteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SaveNoteResponseToJson(this);
}

@JsonSerializable()
class SaveNoteDataResponse {
  final NoteData noteData;

  const SaveNoteDataResponse({required this.noteData});

  factory SaveNoteDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SaveNoteDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SaveNoteDataResponseToJson(this);
}
