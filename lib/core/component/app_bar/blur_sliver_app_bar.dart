import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kimmy/core/utils/extensions.dart';

import '../../utils/global_props.dart';

class BlurSliverAppBar extends StatelessWidget {
  const BlurSliverAppBar({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        expandedHeight: 110.0,
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
            child: Text(title)
                .editProp(fontSize: 32, fontWeight: FontWeight.bold, color: isDark(context) ? Colors.white : Colors.black)
            ,
          ),
          centerTitle: false,
          collapseMode: CollapseMode.pin,
          expandedTitleScale: 1.2,
        ),
      );
  }
}