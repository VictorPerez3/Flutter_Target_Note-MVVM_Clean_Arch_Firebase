// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_note.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveNoteResponse _$SaveNoteResponseFromJson(Map<String, dynamic> json) =>
    SaveNoteResponse(
      data: json['data'] == null
          ? null
          : SaveNoteDataResponse.fromJson(json['data'] as Map<String, dynamic>),
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => ErrorData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SaveNoteResponseToJson(SaveNoteResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errors': instance.errors,
    };

SaveNoteDataResponse _$SaveNoteDataResponseFromJson(
        Map<String, dynamic> json) =>
    SaveNoteDataResponse(
      noteData: NoteData.fromJson(json['noteData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaveNoteDataResponseToJson(
        SaveNoteDataResponse instance) =>
    <String, dynamic>{
      'noteData': instance.noteData,
    };
