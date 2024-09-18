import '../../domain/entities/user_entity.dart';
import '../data/user_data.dart';

abstract class UserMapper {
  static User toModel(UserData data) {
    return User(id: data.id, username: data.username);
  }

  static Map<String, dynamic> toJson(User model) {
    return {'id': model.id, 'username': model.username};
  }
}
