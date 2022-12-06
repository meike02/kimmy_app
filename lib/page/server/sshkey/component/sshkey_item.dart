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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(sshKeyInfo.name)
              .editProp(
              fontSize: 22,
              fontWeight: FontWeight.bold
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(sshKeyInfo.type),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.dns_rounded,
                    size: 14,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  Container(width: 4,),
                  Text("${sshKeyInfo.used}")
                  .editProp(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSecondaryContainer
                  )
                ],
              ).intoContainer(
                padding: EdgeInsets.symmetric(horizontal: 7,vertical: 0),
                margin: EdgeInsets.only(top: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary.editOpacity(0.3)
                  )
                )
              )
            ],
          )
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