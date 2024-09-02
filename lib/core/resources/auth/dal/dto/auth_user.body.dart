import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_user.body.g.dart';

@JsonSerializable()
class AuthUserBody extends Equatable {
  final String username;
  final String password;

  AuthUserBody({
    required String username,
    required String password,
  })  : username = username.trim(),
        password = password.trim();

  factory AuthUserBody.fromJson(Map<String, dynamic> json) =>
      _$AuthUserBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserBodyToJson(this);

  bool get isValid => _isPasswordValid && _isUsernameValid;

  bool get _isPasswordValid {
    return password.length >= 2 &&
        password.length <= 20 &&
        RegExp(r'^[a-zA-Z0-9]+$').hasMatch(password);
  }

  bool get _isUsernameValid {
    return username.length <= 20 && username.isNotEmpty;
  }

  @override
  List<Object?> get props => [username, password];
}
