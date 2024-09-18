// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteData _$NoteDataFromJson(Map<String, dynamic> json) => NoteData(
      id: json['id'] as String,
      title: json['title'] as String,
      noteText: json['noteText'] as String,
      hashtags:
          (json['hashtags'] as List<dynamic>).map((e) => e as String).toList(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$NoteDataToJson(NoteData instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'noteText': instance.noteText,
      'hashtags': instance.hashtags,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
