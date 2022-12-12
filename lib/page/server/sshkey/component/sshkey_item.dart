import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
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
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: SwipeActionCell(
        index: index,
        firstActionWillCoverAllSpaceOnDeleting: false,
        backgroundColor: Colors.transparent,
        controller: controller,
        key: ValueKey<SSHKeyInfo>(sshKeyInfo),
        trailingActions: [
          // IconButton(onPressed: (){}, icon: Icon(Icons.delete_rounded)),
          SwipeAction(
              color: Colors.transparent,
              content: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: isDark(context) ? Colors.black12 : Colors.white12,
                    borderRadius: BorderRadius.circular(30)),
                child: const Icon(Icons.delete_rounded),
              ),
              onTap: (handler) {
                controller.closeAllOpenCell();
                Future.delayed(const Duration(milliseconds: 400)).then((value) {
                  onDelete?.call();
                });
              }),
        ],
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
                        color:
                            colorScheme(context).onSecondaryContainer)
                  ],
                ).intoContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 0),
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
        ).intoContainer(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10)),
      ),
    ).intoInkWell(onTap: () {
      Get.to(() => SSHKeyEditPage(sshKeyInfo: sshKeyInfo));
    }).intoContainer(margin: const EdgeInsets.symmetric(horizontal: 10));
  }
}
