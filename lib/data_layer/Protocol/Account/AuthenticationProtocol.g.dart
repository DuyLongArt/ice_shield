// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthenticationProtocol.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthenticationProtocol _$AuthenticationProtocolFromJson(
  Map<String, dynamic> json,
) => _AuthenticationProtocol(
  username: json['username'] as String,
  password: json['password'] as String,
  jwt: json['jwt'] as String,
);

Map<String, dynamic> _$AuthenticationProtocolToJson(
  _AuthenticationProtocol instance,
) => <String, dynamic>{
  'username': instance.username,
  'password': instance.password,
  'jwt': instance.jwt,
};
