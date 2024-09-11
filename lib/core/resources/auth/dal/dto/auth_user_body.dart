import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_user_body.g.dart';

@JsonSerializable()
class AuthUserBody extends Equatable {
  final String email;
  final String password;

  AuthUserBody({
    required String email,
    required String password,
  })  : email = email.trim(),
        password = password.trim();

  factory AuthUserBody.fromJson(Map<String, dynamic> json) =>
      _$AuthUserBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserBodyToJson(this);

  bool get isValid => _isPasswordValid && _isEmailValid;

  bool get _isPasswordValid {
    return password.length >= 2 &&
        password.length <= 20 &&
        RegExp(r'^[a-zA-Z0-9]+$').hasMatch(password);
  }

  bool get _isEmailValid {
    return email.length <= 20 && email.isNotEmpty;
  }

  @override
  List<Object?> get props => [email, password];
}
