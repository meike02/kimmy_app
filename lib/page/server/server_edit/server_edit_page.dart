import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kimmy/data/model/server_info.dart';
import 'package:kimmy/core/utils/extensions.dart';
import 'package:kimmy/data/store/server_list_controller.dart';
import 'package:kimmy/page/server/server_edit/component/sshkey_selector.dart';

import '../../../core/utils/component_function.dart';

class ServerEditPage extends StatelessWidget {
  ServerEditPage({super.key, this.serverInfo});

  final ServerInfo? serverInfo;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final serverController = Get.put<ServerListController>(ServerListController());

    var isEditing =  serverInfo != null;
    final actionName = isEditing ? "编辑" : "新增";
    var serverData = serverInfo ?? ServerInfo();
    var expanded = true;
    return Scaffold(
      appBar: createBlurAppBar(context,"$actionName服务器信息"),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    createTextFormField(
                        validator: (value) {
                          serverData.name = value;
                          return null;
                        },
                        labelText: "名称"),
                    createTextFormField(
                        validator: (value) {
                          final ipRegExp = RegExp(
                              r"((2(5[0-5]|[0-4]\d))|[0-1]?\d{1,2})(\.((2(5[0-5]|[0-4]\d))|[0-1]?\d{1,2})){3}$");
                          final domainRegExp = RegExp(
                              r"^((?!-)[A-Za-z0-9-]{1,63}(?<!-)\.)+[A-Za-z]{2,6}$");
                          if (!domainRegExp.hasMatch(value)) {
                            return "主机IP或域名不合法！";
                          } else {
                            serverData.host = value;
                            return null;
                          }
                        },
                        labelText: "主机"),
                    createTextFormField(
                        validator: (value) {
                          final portRegExp = RegExp(
                              r"^([1-9]|[1-9]\d{1,3}|[1-6][0-5][0-5][0-3][0-5])$");
                          if (!portRegExp.hasMatch(value)) {
                            return ("端口号不合法！");
                          } else {
                            serverData.port = value;
                            return null;
                          }
                        },
                        labelText: "端口号",
                        hintText: "22"
                    ),
                    createTextFormField(
                        validator: (value) {
                          serverData.username = value;
                          return null;
                        },
                        labelText: "用户名"),
                    StatefulBuilder(builder: (context,setState){
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("是否使用密钥进行连接")
                                  .editProp(fontSize: 16),
                              Switch(
                                  value: serverData.useSSHKey,
                                  onChanged: (value) {
                                    setState(() {
                                      serverData.useSSHKey = value;
                                    });
                                  })
                            ],
                          ).intoContainer(
                              margin: const EdgeInsets.fromLTRB(20, 6, 10, 0)
                          ),
                          // AnimatedSize(
                          //   duration: const Duration(milliseconds: 240),
                          //   // height: serverData.useSSHKey && expanded ? 60 + 220 : 60,
                          //   child: ,
                          // ),
                          SSHKeySelector(
                              onChanged: (keyName){
                                serverData.sshKey = keyName;
                              },
                              useSSHKey: serverData.useSSHKey
                          )
                        ],
                      );
                    })
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(onPressed: () {}, child: const Text("重置")),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() == true) {
                        if(isEditing){
                          serverController.edit(serverData);
                        } else {
                          serverController.add(serverData);
                        }
                      } else {
                        print("不合法！！");
                      }
                    },
                    child: const Text('提交'))
              ],
            ).intoContainer(margin: const EdgeInsets.only(top: 30, bottom: 10)),
          ],
        ),
      ),
    ).loseFocus(context);
  }
}