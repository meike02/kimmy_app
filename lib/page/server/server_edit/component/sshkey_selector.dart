import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kimmy/core/utils/component_function.dart';
import 'package:kimmy/core/utils/extensions.dart';

import '../../../../data/store/sshkey_list_controller.dart';

class SSHKeySelector extends StatefulWidget {
  SSHKeySelector({super.key, required this.onChanged});

  final controller = Get.put<SSHKeyListController>(SSHKeyListController());
  final void Function(bool useSSHKey, String? password, String? sshKeyName)
      onChanged;

  @override
  State<StatefulWidget> createState() {
    return _SSHKeySelectorState();
  }
}

class _SSHKeySelectorState extends State<SSHKeySelector> {
  bool extended = true;
  bool useSSHKey = false;
  String? sshKeyName;
  String? password;
  TextEditingController keyController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("是否使用密钥进行连接").editProp(fontSize: 16),
            Switch(
                value: useSSHKey,
                onChanged: (value) {
                  setState(() {
                    useSSHKey = value;
                  });
                  if(useSSHKey) {
                    password = null;
                  } else {
                    sshKeyName = null;
                  }
                  widget.onChanged(useSSHKey, password, sshKeyName);
                })
          ],
        ).intoContainer(margin: const EdgeInsets.fromLTRB(20, 6, 10, 0)),
        Visibility(
          visible: useSSHKey,
          replacement: createTextFormField(
              validator: (value) {
                final passwordRegExp = RegExp(
                    "(?=.*([a-zA-Z].*))(?=.*[0-9].*)[a-zA-Z0-9-*/+.~!@#\$%^&*()]{6,20}\$");
                if (!passwordRegExp.hasMatch(value)) {
                  return "密码不合法！";
                }
                return null;
              },
              onChanged: (value) {
                password = value;
                widget.onChanged(useSSHKey, password, sshKeyName);
              },
              labelText: "密码",
              maxLines: 1),
          // TODO: 选择rsakey
          child: createTextFormField(
              labelText: "密钥",
              readOnly: true,
              controller: keyController,
              onTap: () {
                if (keyController.text != "") {
                  setState(() {
                    extended = !extended;
                  });
                }
                // widget.expanded(extended);
              },
            validator: (value) {
                if(value.isEmpty) {
                  return "密钥不能为空！";
                }
                return null;
            }
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeInOutQuart,
          child: ConstrainedBox(
            // duration: const Duration(milliseconds: 240),
            // height: extended ? 240 : 0,
            constraints:
                BoxConstraints(maxHeight: useSSHKey && extended ? 220 : 0),
            child:
                GetBuilder<SSHKeyListController>(builder: (sshKeyController) {
              final sshKeyList = sshKeyController.modelList;
              return SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: List.generate(30 + 1, (index) {
                    if (index == 30) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [Icon(Icons.add_rounded)],
                      ).intoInkWell(onTap: () {});
                    }
                    final sshKeyInfo = sshKeyList[0];
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$index${sshKeyInfo.name}").editProp(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            Text(sshKeyInfo.type)
                          ],
                        ).intoContainer(
                            margin: const EdgeInsets.only(top: 8, bottom: 8)),
                        const Divider()
                      ],
                    ).intoInkWell(onTap: () {
                      keyController.text = sshKeyInfo.name;
                      sshKeyName = keyController.text;
                      widget.onChanged(useSSHKey, password, sshKeyName);
                      setState(() {
                        extended = false;
                      });
                      // widget.expanded(extended);
                    });
                  }),
                ),
              ).intoContainer(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              );
            }),
          ),
        )
      ],
    );
  }
}
