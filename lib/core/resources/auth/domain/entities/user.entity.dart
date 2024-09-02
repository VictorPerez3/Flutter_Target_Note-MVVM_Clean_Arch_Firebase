class User {
  final String id;
  final String username;

  const User({required this.id, required this.username});

  @override
  String toString() => 'UserModel [id: $id, username: $username]';
}
