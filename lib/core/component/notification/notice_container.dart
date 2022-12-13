import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kimmy/core/utils/extensions.dart';

import '../../utils/global_props.dart';

class NoticeContainer extends StatelessWidget {
  const NoticeContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var bottomPadding = bottom(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        margin: const EdgeInsets.only(bottom: 60),
        decoration: BoxDecoration(
            color: colorScheme(context).tertiaryContainer,
            borderRadius: BorderRadius.circular(900),
            border: Border.all(
                color: colorScheme(context)
                    .onTertiaryContainer
                    .editOpacity(0.12))),
        child: child,
      ),
    );
  }
}
