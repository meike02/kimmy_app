import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kimmy/core/utils/extensions.dart';
import 'package:kimmy/data/store/navigation_bar_controller.dart';

import '../../core/component/app_bar/blur_app_bar.dart';
import '../../core/component/navigation_bar/flex_navigation_bar.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final barController =
      Get.put<NavigationBarController>(NavigationBarController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationBarController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            controller.selectedPage,
            Align(
              alignment: Alignment.bottomCenter,
              child: FlexNavigationBar(),
            ),
            // Align(
            //   alignment: Alignment.topCenter,
            //   child: BlurAppBar(),
            // ),
          ],
        ),
      ).loseFocus(context);
    });
  }
}
