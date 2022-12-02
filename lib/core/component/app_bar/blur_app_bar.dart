import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kimmy/core/utils/extensions.dart';
import 'package:kimmy/core/utils/global_props.dart';

class BlurAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BlurAppBar({
    super.key,
    required this.name,
    this.centerTitle = false,
    this.actions
  });

  final String name;
  final bool centerTitle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery
        .of(context)
        .padding
        .top;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 14, sigmaY: 14, tileMode: TileMode.mirror),
        child: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          backgroundColor: isDark(context) ? Colors.black12 : Colors.white12,
          title: Text(name).editProp(fontSize: 24, fontWeight: FontWeight.bold),
          automaticallyImplyLeading: true,
          actions: actions,
          centerTitle: centerTitle,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarContentHeight+18);

}