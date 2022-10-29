// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../server_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerInfo _$ServerInfoFromJson(Map<String, dynamic> json) => ServerInfo()
  ..name = json['name'] as String
  ..host = json['host'] as String
  ..port = json['port'] as String
  ..username = json['username'] as String
  ..password = json['password'] as String?
  ..sshKey = json['sshKey'] as String?
  ..useSSHKey = json['useSSHKey'] as bool;

Map<String, dynamic> _$ServerInfoToJson(ServerInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'host': instance.host,
      'port': instance.port,
      'username': instance.username,
      'password': instance.password,
      'sshKey': instance.sshKey,
      'useSSHKey': instance.useSSHKey,
    };
