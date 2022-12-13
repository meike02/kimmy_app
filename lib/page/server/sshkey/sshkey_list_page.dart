import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/controller.dart';
import 'package:get/get.dart';
import 'package:kimmy/core/component/app_bar/blur_sliver_app_bar.dart';
import 'package:kimmy/core/component/notification/delete_notice.dart';
import 'package:kimmy/core/component/notification/notice_container.dart';
import 'package:kimmy/core/component/notification/text_notice.dart';
import 'package:kimmy/core/utils/global_props.dart';
import 'package:kimmy/data/model/sshkey_info.dart';
import 'package:kimmy/page/server/sshkey/component/sshkey_item.dart';
import 'package:kimmy/page/server/sshkey/sshkey_edit_page.dart';
import 'package:kimmy/core/utils/extensions.dart';

import '../../../core/utils/component_function.dart';
import '../../../data/store/sshkey_list_controller.dart';

class SSHKeyListPage extends StatelessWidget {
  SSHKeyListPage({super.key});

  final _listKey = GlobalKey<SliverAnimatedListState>();

  @override
  Widget build(BuildContext context) {
    var bottomPadding = bottom(context);
    SwipeActionController swipeController = SwipeActionController();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const BlurSliverAppBar(
                title: "密钥列表",
              ),
              GetBuilder<SSHKeyListController>(builder: (sshKeyController) {
                final sshKeyList = sshKeyController.modelList;
                return Visibility(
                  visible: sshKeyList.isEmpty,
                  replacement: SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    sliver: SliverAnimatedList(
                      key: _listKey,
                      itemBuilder: (BuildContext context, int index,
                          Animation<double> animation) {
                        final sshKeyInfo = sshKeyList[index];
                        var itemKey = UniqueKey();
                        return SizeTransition(
                          sizeFactor: animation.drive(
                              CurveTween(curve: Curves.easeInOutQuart)),
                          child: SSHKeyItem(
                            index: index,
                            controller: swipeController,
                            key: itemKey,
                            sshKeyInfo: sshKeyInfo,
                            onDelete: () {
                              if(sshKeyInfo.used>0){
                                //此密钥已被使用，无法删除
                                showAnimationWidget((cancelFunc) {
                                  return const TextNotice(text: "此密钥已被使用，无法删除！");
                                },
                                  duration: const Duration(seconds: 4), context: context,
                                );
                              } else {
                                //此密钥未被使用，可以删除
                                showAnimationWidget((cancelFunc) {
                                  return DeleteNotice(
                                    onDisappear: cancelFunc,
                                    onUndo: () {
                                      sshKeyController.modelList.insert(index, sshKeyInfo);
                                      _listKey.currentState!.insertItem(index);
                                    },
                                    onDeleteConfirm: () {
                                      print("已经删除了！！！");
                                    },
                                  );
                                }, context: context,);
                                //渲染删除动画
                                _listKey.currentState!.removeItem(index,
                                        (context, animation) {
                                      swipeController.closeAllOpenCell();
                                      return SizeTransition(
                                        sizeFactor: animation.drive(
                                            CurveTween(curve: Curves.easeInOutQuart)),
                                        child: SSHKeyItem(
                                          index: index,
                                          controller: swipeController,
                                          key: itemKey,
                                          sshKeyInfo: sshKeyInfo,
                                        ),
                                      );
                                    });
                                //删除内存列表中的数据
                                sshKeyController.modelList.removeAt(index);
                              }
                              // sshKeyController.update();
                            },
                          ),
                        );
                      },
                      initialItemCount: sshKeyList.length,
                    ),
                  ),
                  child: SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: const Text("密钥列表为空").intoContainer(
                          margin: const EdgeInsets.only(bottom: 80)),
                    ),
                  ),
                );
              }),
              SliverToBoxAdapter(
                child: GetBuilder<SSHKeyListController>(
                    builder: (sshKeyController) {
                  final sshKeyList = sshKeyController.modelList;
                  return Visibility(
                    visible: sshKeyList.isEmpty,
                    replacement: Container(
                      height: 220,
                    ),
                    child: Container(),
                  );
                }),
              ),
            ],
          ),
          GetBuilder<SSHKeyListController>(builder: (sshKeyController) {
            return Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  Get.to(() => SSHKeyEditPage())?.then((added){
                    if (added == true) {
                      final length = sshKeyController.modelList.length;
                      _listKey.currentState!.insertItem(length-1);
                    }
                  });
                },
                child: const Icon(Icons.add),
              ),
            ).intoContainer(
                margin:
                    EdgeInsets.only(bottom: bottomPadding + 114, right: 10));
          }),
          // DeleteNotice(onUndo: () {
          //   print("undo!!");
          // },)
        ],
      ),
    ).loseFocus(context).intoLoadingPage<SSHKeyListController>();
  }
}
