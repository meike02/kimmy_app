import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kimmy/core/utils/extensions.dart';

import '../../utils/global_props.dart';

class DeleteNotice extends StatefulWidget {
  final int countSecond;
  final void Function() onUndo;
  final void Function() onDisappear;
  final void Function() onDeleteConfirm;

  const DeleteNotice(
      {super.key,
      this.countSecond = 5,
      required this.onUndo,
      required this.onDeleteConfirm,
      required this.onDisappear});

  @override
  State<StatefulWidget> createState() {
    return DeleteNoticeState();
  }
}

class DeleteNoticeState extends State<DeleteNotice> {
  var currentCountSecond = -1;
  var percentage = 1.0;
  late Timer countDownTimer;
  var deleted = true;

  @override
  void initState() {
    super.initState();
    if (currentCountSecond == -1) {
      currentCountSecond = widget.countSecond;
    }
    countDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentCountSecond--;
      if (currentCountSecond == 0) {
        timer.cancel();
        widget.onDisappear();
      }
      setState(() {
        percentage = currentCountSecond / widget.countSecond;
      });
    });
  }

  @override
  void dispose() {
    countDownTimer.cancel();
    if (deleted) {
      widget.onDeleteConfirm();
    }
    widget.onDisappear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bottomPadding = bottom(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Expanded(child: Container()),
          Row(
            children: [
              Expanded(child: Container()),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                margin: EdgeInsets.only(bottom: bottomPadding + 120),
                decoration: BoxDecoration(
                    color: colorScheme(context).tertiaryContainer,
                    borderRadius: BorderRadius.circular(900),
                    border: Border.all(
                        color: colorScheme(context)
                            .onTertiaryContainer
                            .editOpacity(0.12))),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          alignment: Alignment.center,
                          child: Text(currentCountSecond.toString()),
                        ),
                        CircularProgressIndicator(
                          color: colorScheme(context).tertiary,
                          strokeWidth: 2,
                          value: percentage,
                        ).sized(width: 22, height: 22)
                      ],
                    ),
                    Container(width: 8),
                    const Text("密钥 id_rsa 已被删除").editProp(fontSize: 13),
                    Container(width: 18),
                    TextButton(
                        onPressed: () {
                          if (deleted) {
                            deleted = false;
                            widget.onUndo();
                            widget.onDisappear();
                          }
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Text("点击撤销").editProp(fontSize: 13)),
                    Container(width: 8),
                  ],
                ),
              ),
              Expanded(child: Container())
            ],
          )
        ],
      ),
    );
  }
}
