import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../converters/color_converter.dart';
import '../converters/text_align_converter.dart';

part 'note_data.g.dart';

@JsonSerializable()
class NoteData {
  final String id;
  final String title;
  final String noteText;
  final List<String> hashtags;
  final DateTime updatedAt;

  @ColorConverter()
  final Color backgroundColor;

  @TextAlignConverter()
  final TextAlign alignmentText;

  NoteData({
    required this.id,
    required this.title,
    required this.noteText,
    required this.hashtags,
    required this.updatedAt,
    required this.backgroundColor,
    required this.alignmentText,
  });

  factory NoteData.fromJson(Map<String, dynamic> json) =>
      _$NoteDataFromJson(json);

  Map<String, dynamic> toJson() => _$NoteDataToJson(this);
}
