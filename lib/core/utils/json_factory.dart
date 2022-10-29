import 'package:kimmy/data/model/base_model.dart';
import 'package:kimmy/data/model/sshkey_info.dart';
import 'package:kimmy/data/model/server_info.dart';

class JsonFactory {
  static Map<String, dynamic> toJson(BaseModel data) {
    if (data is SSHKeyInfo) {
      return data.toJson();
    } else if (data is ServerInfo) {
      return data.toJson();
    } else {
      throw Exception("此类型未注册！");
    }
  }

  static T fromJson<T extends BaseModel>(Map<String, dynamic> json) {
    if (T == SSHKeyInfo) {
      return SSHKeyInfo.fromJson(json) as T;
    } else if (T == ServerInfo) {
      return ServerInfo.fromJson(json) as T;
    } else {
      throw Exception("此类型未注册！");
    }
  }

  static List<T> fromJsonToList<T extends BaseModel>(
      List<Map<String, dynamic>>? jsonList) {
    if (T == SSHKeyInfo) {
      return SSHKeyInfo.fromJsonToList(jsonList) as List<T>? ?? [];
    } else if (T == ServerInfo) {
      return ServerInfo.fromJsonToList(jsonList) as List<T>? ?? [];
    } else {
      throw Exception("此类型未注册！");
    }
  }
}
