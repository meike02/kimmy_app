import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:flutter_swipe_action_cell/core/controller.dart';
import 'package:kimmy/core/utils/extensions.dart';

import '../../utils/global_props.dart';

class ItemCard extends StatelessWidget {

  final int index;
  final SwipeActionController controller;
  final Function()? onDelete;
  final Function()? onTap;
  final Widget child;

  const ItemCard({
    super.key,
    required this.index,
    required this.controller,
    this.onDelete,
    required this.child,
    this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 12),
      child: SwipeActionCell(
        index: index,
        firstActionWillCoverAllSpaceOnDeleting: false,
        backgroundColor: Colors.transparent,
        controller: controller,
        key: ValueKey(child),
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
        child: child.intoContainer(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10)),
      ),
    ).intoInkWell(onTap: onTap)
        .intoContainer(margin: const EdgeInsets.symmetric(horizontal: 10));
  }

}