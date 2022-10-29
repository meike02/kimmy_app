import 'package:json_annotation/json_annotation.dart';
import 'package:kimmy/core/utils/encrypt.dart';
import 'package:kimmy/data/model/base_model.dart';

part 'part/server_info.g.dart';

@JsonSerializable()
class ServerInfo implements BaseModel{
  @override
  get id => name;

  ServerInfo();
  late String name;
  late String host;
  late String port;
  late String username;
  String? password;
  String? sshKey;
  bool useSSHKey = false;

  factory ServerInfo.fromJson(Map<String, dynamic> json) {
    final serverInfo = _$ServerInfoFromJson(json);
    serverInfo.password = decrypt(serverInfo.password);
    return serverInfo;
  }

  static List<ServerInfo>? fromJsonToList(List<Map<String,dynamic>>? jsonList) {
    return jsonList?.map((json) => ServerInfo.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    if(password != null){
      password = encrypt(password);
    }
    final jsonMap = _$ServerInfoToJson(this);
    return jsonMap;
  }
}