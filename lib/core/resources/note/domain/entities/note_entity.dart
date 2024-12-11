import 'package:flutter/material.dart';

class Note {
  final String id;
  final String noteType;
  final String title;
  final String noteText;
  final bool hide;
  final DateTime updatedAt;
  final Color backgroundColor;
  final TextAlign alignmentText;

  const Note({
    required this.id,
    required this.noteType,
    required this.title,
    required this.noteText,
    required this.hide,
    required this.updatedAt,
    required this.backgroundColor,
    required this.alignmentText,
  });

  @override
  String toString() =>
      'Note [id: $id, noteType: $noteType, title: $title, noteText: $noteText, hide: $hide, updatedAt: $updatedAt, backgroundColor: $backgroundColor, alignmentText: $alignmentText]';
}
