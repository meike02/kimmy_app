import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kimmy/core/utils/extensions.dart';
import 'package:kimmy/core/utils/global_props.dart';

class BlurAppBar extends StatelessWidget{
  const BlurAppBar({super.key,required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 14, sigmaY: 14, tileMode: TileMode.mirror),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, top+12, 10, 8),
          child: Row(
            children: [
              const Text("密钥列表").editProp(fontSize: 24,fontWeight: FontWeight.bold)
            ],
          ).intoContainer(height: appBarContentHeight),
        ),
      ),
    ).intoContainer(
      color: isDark(context) ? Colors.black12 : Colors.white12
    );
  }

}