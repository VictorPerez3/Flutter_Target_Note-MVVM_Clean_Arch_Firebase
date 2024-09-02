// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUserResponse _$AuthUserResponseFromJson(Map<String, dynamic> json) =>
    AuthUserResponse(
      data: json['data'] == null
          ? null
          : AuthUserDataResponse.fromJson(json['data'] as Map<String, dynamic>),
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => ErrorData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuthUserResponseToJson(AuthUserResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errors': instance.errors,
    };

AuthUserDataResponse _$AuthUserDataResponseFromJson(
        Map<String, dynamic> json) =>
    AuthUserDataResponse(
      user: UserData.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$AuthUserDataResponseToJson(
        AuthUserDataResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
    };
