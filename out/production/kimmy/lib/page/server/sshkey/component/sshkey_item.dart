import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kimmy/data/model/sshkey_info.dart';
import 'package:kimmy/page/server/sshkey/sshkey_edit_page.dart';
import 'package:kimmy/core/utils/extensions.dart';

class SSHKeyItem extends StatelessWidget {
  const SSHKeyItem({required super.key, required this.sshKeyInfo});

  final SSHKeyInfo sshKeyInfo;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(sshKeyInfo.name)
          .editProp(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
          Text("Type: ${sshKeyInfo.type}")
        ],
      ).intoContainer(
        margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 10)
      ),
    ).intoInkWell(
      onTap: () {
        Get.to(() => SSHKeyEditPage(sshKeyInfo: sshKeyInfo));
      }
    );
  }
}