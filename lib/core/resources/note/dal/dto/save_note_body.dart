import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../converters/color_converter.dart';
import '../converters/text_align_converter.dart';

part 'save_note_body.g.dart';

@JsonSerializable()
class SaveNoteBody extends Equatable {
  final String title;
  final String noteText;
  final List<String> hashtags;
  final DateTime updatedAt;

  @ColorConverter()
  final Color backgroundColor;

  @TextAlignConverter()
  final TextAlign alignmentText;

  SaveNoteBody({
    required String title,
    required String noteText,
    required List<String> hashtags,
    required this.updatedAt,
    required this.backgroundColor,
    required this.alignmentText,
  })  : title = title.trim(),
        noteText = noteText.trim(),
        hashtags = hashtags.map((tag) => tag.trim()).toList();

  factory SaveNoteBody.fromJson(Map<String, dynamic> json) =>
      _$SaveNoteBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SaveNoteBodyToJson(this);

  bool get isValid =>
      _isTitleValid && _isNoteTextValid && _areHashtagsValid;

  bool get _isTitleValid => title.isNotEmpty;

  bool get _isNoteTextValid => noteText.isNotEmpty;

  bool get _areHashtagsValid =>
      hashtags.isNotEmpty && hashtags.every((tag) => tag.isNotEmpty);

  @override
  List<Object?> get props => [
    title,
    noteText,
    hashtags,
    updatedAt,
    backgroundColor,
    alignmentText,
  ];
}
