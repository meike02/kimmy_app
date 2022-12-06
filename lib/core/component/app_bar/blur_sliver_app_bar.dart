import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kimmy/core/utils/extensions.dart';

import '../../utils/global_props.dart';

class BlurSliverAppBar extends StatelessWidget {
  const BlurSliverAppBar({
    super.key,
    required this.title,
    this.action
  });

  final String title;
  final Widget? action;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        expandedHeight: 100.0,
        floating: false,
        pinned: true,
        snap: false,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        backgroundColor: isDark(context) ? Colors.black12 : Colors.white12,
        elevation: 0,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          title:
          BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 14, sigmaY: 14, tileMode: TileMode.mirror),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title)
                    .editProp(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark(context) ? Colors.white : Colors.black,
                )
              ],
            ),
          ),
          centerTitle: false,
          collapseMode: CollapseMode.pin,
          expandedTitleScale: 1.2,
        ),
      );
  }
}