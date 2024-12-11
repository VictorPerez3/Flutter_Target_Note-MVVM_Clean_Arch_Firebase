// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_note_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveNoteBody _$SaveNoteBodyFromJson(Map<String, dynamic> json) => SaveNoteBody(
      title: json['title'] as String,
      noteText: json['noteText'] as String,
      noteType: json['noteType'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      backgroundColor:
          const ColorConverter().fromJson(json['backgroundColor'] as int),
      alignmentText:
          const TextAlignConverter().fromJson(json['alignmentText'] as String),
      hide: json['hide'] as bool,
    );

Map<String, dynamic> _$SaveNoteBodyToJson(SaveNoteBody instance) =>
    <String, dynamic>{
      'noteType': instance.noteType,
      'title': instance.title,
      'noteText': instance.noteText,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'backgroundColor':
          const ColorConverter().toJson(instance.backgroundColor),
      'alignmentText':
          const TextAlignConverter().toJson(instance.alignmentText),
      'hide': instance.hide,
    };
