class Note {
  final String id;
  final String title;
  final String noteText;
  final List<String> hashtags;
  final DateTime updatedAt;

  const Note(
      {required this.id,
      required this.title,
      required this.noteText,
      required this.hashtags,
      required this.updatedAt});

  @override
  String toString() =>
      'NoteModel [id: $id, title: $title, noteText: $noteText, hashtag: $hashtags, updateAt: $updatedAt]';
}
