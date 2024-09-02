// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUserBody _$AuthUserBodyFromJson(Map<String, dynamic> json) => AuthUserBody(
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$AuthUserBodyToJson(AuthUserBody instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
