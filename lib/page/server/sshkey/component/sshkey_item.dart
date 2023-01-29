import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:kimmy/core/component/container/item_card.dart';
import 'package:kimmy/data/model/sshkey_info.dart';
import 'package:kimmy/page/server/sshkey/sshkey_edit_page.dart';
import 'package:kimmy/core/utils/extensions.dart';

import '../../../../core/utils/global_props.dart';

class SSHKeyItem extends StatelessWidget {
  const SSHKeyItem(
      {required super.key,
      required this.index,
      required this.sshKeyInfo,
      required this.controller,
      this.onDelete});

  final int index;
  final SSHKeyInfo sshKeyInfo;
  final SwipeActionController controller;
  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return ItemCard(
        index: index,
        controller: controller,
        onDelete: onDelete,
        onTap: () {
          Get.to(() => SSHKeyEditPage(sshKeyInfo: sshKeyInfo));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(sshKeyInfo.name)
                .editProp(fontSize: 22, fontWeight: FontWeight.bold),
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
                      color: colorScheme(context).onSecondaryContainer,
                    ),
                    Container(
                      width: 4,
                    ),
                    Text("${sshKeyInfo.used}").editProp(
                        fontSize: 14,
                        color: colorScheme(context).onSecondaryContainer)
                  ],
                ).intoContainer(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 0),
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: colorScheme(context).secondaryContainer,
                        border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .editOpacity(0.3))))
              ],
            )
          ],
        ));
  }
}
