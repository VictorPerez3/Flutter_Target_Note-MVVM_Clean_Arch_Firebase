class Note {
  final String id;
  final String title;
  final String noteText;

  const Note({
    required this.id,
    required this.title,
    required this.noteText,
  });

  @override
  String toString() => 'NoteModel [id: $id, title: $title, noteText: $noteText]';
}
