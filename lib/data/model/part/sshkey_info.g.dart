// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../sshkey_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SSHKeyInfo _$SSHKeyInfoFromJson(Map<String, dynamic> json) => SSHKeyInfo()
  ..name = json['name'] as String
  ..privateKeyData = json['privateKeyData'] as String
  ..type = json['type'] as String
  ..password = json['password'] as String?;

Map<String, dynamic> _$SSHKeyInfoToJson(SSHKeyInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'privateKeyData': instance.privateKeyData,
      'type': instance.type,
      'password': instance.password,
    };
