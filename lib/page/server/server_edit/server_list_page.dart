import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/controller.dart';
import 'package:get/get.dart';
import 'package:kimmy/core/utils/extensions.dart';
import 'package:kimmy/data/model/monitor_info.dart';
import 'package:kimmy/data/store/server_list_controller.dart';
import 'package:kimmy/page/server/server_edit/component/server_item.dart';
import 'package:kimmy/page/server/server_edit/server_edit_page.dart';

import '../../../core/component/app_bar/blur_app_bar.dart';
import '../../../core/component/app_bar/blur_sliver_app_bar.dart';
import '../../../core/component/notification/delete_notice.dart';
import '../../../core/utils/component_function.dart';
import '../../../core/utils/global_props.dart';
import '../../../data/model/sshkey_info.dart';
import '../../../data/store/sshkey_list_controller.dart';

class ServerListPage extends StatelessWidget {
  ServerListPage({super.key});

  final controller = Get.put<ServerListController>(ServerListController());
  final sshKeyController = Get.find<SSHKeyListController>();
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
              GetBuilder<ServerListController>(builder: (serverController) {
                final serverList = serverController.modelList;
                final monitorStreamList = serverController.monitorInfoStreamList;
                return Visibility(
                  visible: serverList.isEmpty,
                  replacement: SliverPadding(
                    padding: const EdgeInsets.only(top: 12),
                    sliver: SliverAnimatedList(
                      key: _listKey,
                      itemBuilder: (BuildContext context, int index,
                          Animation<double> animation) {
                        final serverInfo = serverList[index];
                        var itemKey = UniqueKey();
                        return SizeTransition(
                          sizeFactor: animation.drive(
                              CurveTween(curve: Curves.easeInOutQuart)),
                          child: ServerItem(
                            index: index,
                            controller: swipeController,
                            key: itemKey,
                            serverInfo: serverInfo,
                            monitorInfoStream: monitorStreamList[index],
                            onDelete: () {
                              showAnimationWidget((cancelFunc) {
                                return DeleteNotice(
                                  noticeText: "服务器 ${serverInfo.name} 已被删除",
                                  onDisappear: cancelFunc,
                                  onUndo: () {
                                    serverController.modelList.insert(index, serverInfo);
                                    _listKey.currentState!.insertItem(index);
                                  },
                                  onDeleteConfirm: () {
                                    // 新增服务器时需要同时修改sshKey的使用次数
                                    if(serverInfo.useSSHKey){
                                      var sshKeyData = SSHKeyInfo.fromJson(sshKeyController.get(serverInfo.sshKey)!);
                                      sshKeyData.used--;
                                      sshKeyController.edit(sshKeyData);
                                    }
                                    serverController.delete(serverInfo);
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
                                      child: ServerItem(
                                        index: index,
                                        controller: swipeController,
                                        key: itemKey,
                                        serverInfo: serverInfo,
                                        monitorInfoStream: null,
                                      ),
                                    );
                                  });
                              //删除内存列表中的数据
                              serverController.modelList.removeAt(index);
                              // sshKeyController.update();
                            },
                          ),
                        );
                      },
                      initialItemCount: serverList.length,
                    ),
                  ),
                  child: SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: const Text("服务器列表为空").intoContainer(
                          margin: const EdgeInsets.only(bottom: 80)),
                    ),
                  ),
                );
              }),
              SliverToBoxAdapter(
                child: GetBuilder<ServerListController>(
                    builder: (serverController) {
                      final sshKeyList = serverController.modelList;
                      return Visibility(
                        visible: sshKeyList.isEmpty,
                        replacement: Container(
                          height: bottomPadding + 180,
                        ),
                        child: Container(),
                      );
                    }),
              ),
            ],
          ),
          GetBuilder<ServerListController>(builder: (sshKeyController) {
            return Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  Get.to(() => ServerEditPage())?.then((added){
                    if (added == true) {
                      final length = sshKeyController.modelList.length;
                      _listKey.currentState?.insertItem(length-1);
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
    ).loseFocus(context).intoLoadingPage<ServerListController>();
  }
}
