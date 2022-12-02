import 'dart:io';

import 'package:dartssh2/dartssh2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kimmy/data/model/sshkey_info.dart';
import 'package:kimmy/data/store/sshkey_list_controller.dart';
import 'package:kimmy/core/utils/extensions.dart';

import '../../../core/component/app_bar/blur_app_bar.dart';
import '../../../core/utils/component_function.dart';

class SSHKeyEditPage extends StatelessWidget {
  SSHKeyEditPage({super.key, this.sshKeyInfo});

  final SSHKeyInfo? sshKeyInfo;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bool isEditing = sshKeyInfo != null;
    final actionName = isEditing ? "修改" : "新增";
    var sshKeyData = sshKeyInfo ?? SSHKeyInfo();

    TextEditingController sshKeyDataController = TextEditingController();
    final sshKeyController = Get.find<SSHKeyListController>();

    return Scaffold(
      appBar: BlurAppBar(name: "$actionName密钥信息"),
      body: Column(
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  createTextFormField(
                      defaultValue: isEditing ? sshKeyData.name : null,
                      enabled: !isEditing,
                      validator: (value) {
                        sshKeyData.name = value;
                        return null;
                      },
                      labelText: "名称"),
                  createTextFormField(
                      controller: sshKeyDataController,
                      defaultValue:
                          isEditing ? sshKeyData.privateKeyData : null,
                      validator: (value) {
                        try {
                          // var sshPem = SSHPem.decode(value);
                          sshKeyData.privateKeyData = value;
                          // sshKeyData.type = sshPem.type;
                          sshKeyData.type = "OPEN-SSHKEY";
                        } catch (e) {
                          return "密钥不合法！";
                        }
                        return null;
                      },
                      labelText: "密钥",
                      maxLines: 5,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.any,
                            );
                            File? sshKeyFile = result == null
                                ? null
                                : File(result.files.single.path!);
                            // XTypeGroup typeGroup = XTypeGroup(
                            //   extensions: [""],
                            //   macUTIs: ["public.data"]
                            // );
                            // final initialDirectory = (await getApplicationSupportDirectory()).path;
                            // final XFile? sshKeyFile = await openFile(
                            //   acceptedTypeGroups: <XTypeGroup>[typeGroup],
                            //   initialDirectory: initialDirectory,
                            // );
                            if (sshKeyFile != null) {
                              sshKeyDataController.text =
                                  await sshKeyFile.readAsString();
                            }
                          },
                          icon: const Icon(Icons.input_rounded))),
                  createTextFormField(
                      defaultValue: isEditing ? sshKeyData.password : null,
                      validator: (value) {
                        sshKeyData.password = value;
                        return null;
                      },
                      labelText: "密码",
                      maxLines: 1,
                      nullable: true),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () {
                  print(Get.previousRoute);
                },
                child: const Text("重置"),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() == true) {
                      if (isEditing) {
                        await sshKeyController.edit(sshKeyData);
                      } else {
                        await sshKeyController.add(sshKeyData);
                      }
                      Get.back();
                    }
                  },
                  child: const Text('提交'))
            ],
          ).intoContainer(margin: const EdgeInsets.only(top: 30, bottom: 10)),
        ],
      ),
    ).loseFocus(context);
  }
}
