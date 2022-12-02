import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kimmy/core/component/app_bar/blur_app_bar.dart';
import 'package:kimmy/core/component/app_bar/blur_sliver_app_bar.dart';
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
    var bottom = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const BlurSliverAppBar(title: "密钥列表"),
              GetBuilder<SSHKeyListController>(builder: (sshKeyController) {
                final sshKeyList = sshKeyController.modelList;
                return Visibility(
                  visible: sshKeyList.isEmpty,
                  replacement: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final sshKeyInfo = sshKeyList[0];
                      return SSHKeyItem(
                        key: ValueKey(sshKeyInfo.name),
                        sshKeyInfo: sshKeyInfo,
                      ).intoContainer(
                          padding: const EdgeInsets.symmetric(horizontal: 10));
                    }, childCount: 20),
                  ),
                  child: const Center(
                    child: Text("密钥列表为空"),
                  ),
                );
              }),
            ],
          ),
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
      ),
    ).loseFocus(context).intoLoadingPage<SSHKeyListController>();
  }
}
