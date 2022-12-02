import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kimmy/data/store/navigation_bar_controller.dart';
import 'package:kimmy/core/utils/extensions.dart';

import '../../../../core/utils/global_props.dart';
import '../shadow_clipper/cliper.dart';
import 'navigation_item.dart';

class FlexNavigationBar extends StatelessWidget {
  FlexNavigationBar({super.key});

  final barController = Get.find<NavigationBarController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottom = MediaQuery.of(context).padding.bottom;
    final top = MediaQuery.of(context).padding.top;
    const double bottomPadding = 0;
    const double sidePadding = 14;
    const double navigationBarHeight = 68;
    const double navigationBarRadius = 20;
    const EdgeInsets navigationBarEdgeInsets = EdgeInsets.only(
        left: sidePadding,
        right: sidePadding,
        bottom: bottomPadding);
    return GetBuilder<NavigationBarController>(builder: (controller) {
      return Stack(
        children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 14, sigmaY: 14, tileMode: TileMode.mirror),
                  child: Container(),
                ),
              ).intoContainer(
                  height: navigationBarHeight,
                  margin: navigationBarEdgeInsets,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(navigationBarRadius)),
                  )).intoContainer(
                  padding:
                  EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom))),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: navigationBarHeight,
                  margin: navigationBarEdgeInsets,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromARGB(
                            isDark(context) ? 34 : 136, 255, 255, 255),
                        width: 1.6),
                    borderRadius: const BorderRadius.all(Radius.circular(navigationBarRadius)),
                  )).intoContainer(
                  padding:
                  EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom))),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: navigationBarHeight,
                  margin: navigationBarEdgeInsets,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color:
                            Color.fromARGB(isDark(context) ? 198 : 34, 0, 0, 0),
                        width: 0.4),
                    borderRadius: const BorderRadius.all(Radius.circular(navigationBarRadius)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        controller.length,
                        (index) => NavigationItem(
                            navigationItemInfo:
                                controller.navigationList[index],
                            itemIndex: index)),
                  )).intoContainer(
                  padding:
                  EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom))),
          ShadowClipper(
            borderRadius: navigationBarRadius,
            boundWidth: size.width - sidePadding * 2,
            boundHeight: navigationBarHeight,
            yOffset: (size.height) / 2 - bottom - bottomPadding - navigationBarHeight /2,
            backgroundColor: Colors.black26,
          )
        ],
      );
    });
  }
}
