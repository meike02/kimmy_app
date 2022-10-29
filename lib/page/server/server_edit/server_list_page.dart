import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kimmy/core/utils/extensions.dart';
import 'package:kimmy/data/store/server_list_controller.dart';
import 'package:kimmy/page/server/server_edit/component/server_item.dart';
import 'package:kimmy/page/server/server_edit/server_edit_page.dart';

import '../../../core/utils/component_function.dart';
import '../../../core/utils/global_props.dart';

class ServerListPage extends StatelessWidget{
  ServerListPage({super.key});

  final controller = Get.put<ServerListController>(ServerListController());

  @override
  Widget build(BuildContext context) {
    var bottom = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: createBlurAppBar(context,"服务器列表"),
      body: Stack(
        children: [
          GetBuilder<ServerListController>(builder: (serverController) {
            final serverList = serverController.modelList;
            return Visibility(
              visible: serverList.isEmpty,
              replacement: ListView.builder(
                // itemCount: sshKeyList.length,
                  itemCount: 20,
                  padding: EdgeInsets.only(
                      top: appBarHeight(context), bottom: 106 + bottom),
                  itemBuilder: (context, index) {
                    final serverInfo = serverList[0];
                    return ServerItem(
                      serverInfo: serverInfo,
                    );
                  }),
              child: const Center(
                child: Text("密钥列表为空"),
              ),
            );
          }),
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