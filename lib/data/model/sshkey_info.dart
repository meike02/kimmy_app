import 'package:json_annotation/json_annotation.dart';
import 'package:kimmy/core/utils/encrypt.dart';
import 'package:kimmy/data/model/base_model.dart';

part 'part/sshkey_info.g.dart';
@JsonSerializable()
class SSHKeyInfo implements BaseModel{
  @override
  get id => name;

  SSHKeyInfo();
  late String name;
  late String privateKeyData;
  late String type;
  String? password;
  int used = 0;

  factory SSHKeyInfo.fromJson(json) {
    final sshKeyInfo = _$SSHKeyInfoFromJson(json);
    sshKeyInfo.password = decrypt(sshKeyInfo.password);
    sshKeyInfo.privateKeyData = decrypt(sshKeyInfo.privateKeyData)!;
    return sshKeyInfo;
  }

  static List<SSHKeyInfo>? fromJsonToList(List<Map<String,dynamic>>? jsonList) {
    return jsonList?.map((json) => SSHKeyInfo.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson(){
    password = encrypt(password);
    privateKeyData = encrypt(privateKeyData)!;
    return _$SSHKeyInfoToJson(this);
  }
}