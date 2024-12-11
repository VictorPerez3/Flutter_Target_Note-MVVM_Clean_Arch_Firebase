import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../converters/color_converter.dart';
import '../converters/text_align_converter.dart';

part 'save_note_body.g.dart';

@JsonSerializable()
class SaveNoteBody extends Equatable {
  final String noteType;
  final String title;
  final String noteText;
  final DateTime updatedAt;

  @ColorConverter()
  final Color backgroundColor;

  @TextAlignConverter()
  final TextAlign alignmentText;

  final bool hide;

  SaveNoteBody({
    required String title,
    required String noteText,
    required this.noteType,
    required this.updatedAt,
    required this.backgroundColor,
    required this.alignmentText,
    required this.hide,
  })  : title = title.trim(),
        noteText = noteText.trim();

  factory SaveNoteBody.fromJson(Map<String, dynamic> json) =>
      _$SaveNoteBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SaveNoteBodyToJson(this);

  bool get isValid => _isTitleValid && _isNoteTextValid;

  bool get _isTitleValid => title.isNotEmpty;

  bool get _isNoteTextValid => noteText.isNotEmpty;

  @override
  List<Object?> get props => [
        title,
        noteText,
        updatedAt,
        backgroundColor,
        alignmentText,
        hide,
      ];
}
