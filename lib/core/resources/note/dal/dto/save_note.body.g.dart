// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_note.body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveNoteBody _$SaveNoteBodyFromJson(Map<String, dynamic> json) => SaveNoteBody(
      title: json['title'] as String,
      noteText: json['noteText'] as String,
      hashtags:
          (json['hashtags'] as List<dynamic>).map((e) => e as String).toList(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$SaveNoteBodyToJson(SaveNoteBody instance) =>
    <String, dynamic>{
      'title': instance.title,
      'noteText': instance.noteText,
      'hashtags': instance.hashtags,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
