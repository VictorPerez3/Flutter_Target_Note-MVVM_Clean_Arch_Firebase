// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUserBody _$AuthUserBodyFromJson(Map<String, dynamic> json) => AuthUserBody(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$AuthUserBodyToJson(AuthUserBody instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
