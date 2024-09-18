import 'package:json_annotation/json_annotation.dart';

import '../../../../base/dal/data/error_data.dart';
import '../data/user_data.dart';

part 'auth_user_response.g.dart';

@JsonSerializable()
class AuthUserResponse {
  final AuthUserDataResponse? data;
  final List<ErrorData>? errors;

  const AuthUserResponse({required this.data, required this.errors})
      : assert(data != null || errors != null);

  factory AuthUserResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserResponseToJson(this);
}

@JsonSerializable()
class AuthUserDataResponse {
  final UserData user;
  final String token;

  const AuthUserDataResponse({required this.user, required this.token});

  factory AuthUserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthUserDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserDataResponseToJson(this);
}