import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kimmy/core/utils/global_props.dart';
import 'package:kimmy/page/server/sshkey/component/sshkey_item.dart';
import 'package:kimmy/page/server/sshkey/sshkey_edit_page.dart';
import 'package:kimmy/core/utils/extensions.dart';

import '../../../core/utils/component_function.dart';
import '../../../data/store/sshkey_list_controller.dart';

class SSHKeyListPage extends StatelessWidget {
  SSHKeyListPage({super.key});

  final controller = Get.put<SSHKeyListController>(SSHKeyListController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var top = MediaQuery.of(context).padding.top;
    var bottom = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: createBlurAppBar(context,"密钥列表"),
      body: Stack(
        children: [
          GetBuilder<SSHKeyListController>(builder: (sshKeyController) {
            final sshKeyList = sshKeyController.modelList;
            return Visibility(
              visible: sshKeyList.isEmpty,
              replacement: ListView.builder(
                  // itemCount: sshKeyList.length,
                  itemCount: 20,
                  padding: EdgeInsets.only(
                      top: appBarHeight(context), bottom: 106 + bottom),
                  itemBuilder: (context, index) {
                    final sshKeyInfo = sshKeyList[0];
                    return SSHKeyItem(
                      key: ValueKey(sshKeyInfo.name),
                      sshKeyInfo: sshKeyInfo,
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
                Get.to(() => SSHKeyEditPage());
              },
              child: const Icon(Icons.add),
            ),
          ).intoContainer(
              margin:
                  EdgeInsets.only(bottom: bottom + 22 + 52 + 24, right: 10)),
        ],
      ).intoContainer(padding: const EdgeInsets.symmetric(horizontal: 10)),
    ).loseFocus(context).intoLoadingPage<SSHKeyListController>();
  }
}