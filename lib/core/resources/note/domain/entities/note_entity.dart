import 'package:flutter/material.dart';

class Note {
  final String id;
  final String title;
  final String noteText;
  final List<String> hashtags;
  final DateTime updatedAt;
  final Color backgroundColor;
  final TextAlign alignmentText;

  const Note({
    required this.id,
    required this.title,
    required this.noteText,
    required this.hashtags,
    required this.updatedAt,
    required this.backgroundColor,
    required this.alignmentText,
  });

  @override
  String toString() =>
      'NoteModel [id: $id, title: $title, noteText: $noteText, hashtags: $hashtags, updatedAt: $updatedAt, backgroundColor: $backgroundColor, alignmentText: $alignmentText]';
}
