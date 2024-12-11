// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteData _$NoteDataFromJson(Map<String, dynamic> json) => NoteData(
      id: json['id'] as String,
      noteType: json['noteType'] as String,
      title: json['title'] as String,
      noteText: json['noteText'] as String,
      hide: json['hide'] as bool,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      backgroundColor:
          const ColorConverter().fromJson(json['backgroundColor'] as int),
      alignmentText:
          const TextAlignConverter().fromJson(json['alignmentText'] as String),
    );

Map<String, dynamic> _$NoteDataToJson(NoteData instance) => <String, dynamic>{
      'id': instance.id,
      'noteType': instance.noteType,
      'title': instance.title,
      'noteText': instance.noteText,
      'hide': instance.hide,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'backgroundColor':
          const ColorConverter().toJson(instance.backgroundColor),
      'alignmentText':
          const TextAlignConverter().toJson(instance.alignmentText),
    };
