import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kimmy/core/utils/extensions.dart';
import 'package:kimmy/data/store/server_list_controller.dart';
import 'package:kimmy/page/server/server_edit/component/server_item.dart';
import 'package:kimmy/page/server/server_edit/server_edit_page.dart';

import '../../../core/component/app_bar/blur_app_bar.dart';
import '../../../core/component/app_bar/blur_sliver_app_bar.dart';
import '../../../core/utils/component_function.dart';
import '../../../core/utils/global_props.dart';

class ServerListPage extends StatelessWidget {
  ServerListPage({super.key});

  final controller = Get.put<ServerListController>(ServerListController());

  @override
  Widget build(BuildContext context) {
    var bottom = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const BlurSliverAppBar(title: "服务器列表"),
              GetBuilder<ServerListController>(builder: (serverController) {
                final serverList = serverController.modelList;
                return Visibility(
                  visible: serverList.isEmpty,
                  replacement: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    final serverInfo = serverList[0];
                    return ServerItem(
                      serverInfo: serverInfo,
                    ).intoContainer(
                        padding: const EdgeInsets.symmetric(horizontal: 10));
                  }, childCount: 3)),
                  child: SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: const Text("服务器列表为空")
                          .intoContainer(margin: const EdgeInsets.only(bottom: 80)),
                    ),
                  ),
                );
              }),
              SliverToBoxAdapter(
                child: GetBuilder<ServerListController>(builder: (serverListController) {
                  final sshKeyList = serverListController.modelList;
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
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                Get.to(() => ServerEditPage());
              },
              child: const Icon(Icons.add),
            ),
          ).intoContainer(
              margin:
                  EdgeInsets.only(bottom: bottom + 22 + 52 + 24, right: 10)),
        ],
      ).intoContainer(padding: const EdgeInsets.symmetric(horizontal: 10)),
    ).loseFocus(context).intoLoadingPage<ServerListController>();
  }
}
