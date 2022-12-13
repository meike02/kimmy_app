import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kimmy/core/component/notification/notice_container.dart';
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
  var currentCountSecond = -1.0;
  var percentage = 1.0;
  Timer? countDownTimer;
  var deleted = true;

  @override
  void initState() {
    super.initState();
    if (currentCountSecond == -1) {
      currentCountSecond = widget.countSecond.toDouble();
    }
  }

  @override
  void dispose() {
    countDownTimer!.cancel();
    if (deleted) {
      widget.onDeleteConfirm();
    }
    widget.onDisappear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatefulBuilder(builder: (context, setSubState) {
          countDownTimer ??=
              Timer.periodic(const Duration(milliseconds: 8), (timer) {
                currentCountSecond -= 0.008;
                if (currentCountSecond <= 0) {
                  countDownTimer!.cancel();
                  widget.onDisappear();
                }
                setSubState(() {
                  percentage = currentCountSecond / widget.countSecond;
                });
              });
          return Stack(
            children: [
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                child: Text((currentCountSecond.toInt() + 1).toString()),
              ),
              CircularProgressIndicator(
                color: colorScheme(context).tertiary,
                strokeWidth: 2,
                value: percentage,
              ).sized(width: 22, height: 22)
            ],
          );
        }),
        const SizedBox(width: 8, height: 0,),
        const Text("密钥 id_rsa 已被删除").editProp(fontSize: 13),
        const SizedBox(width: 18, height: 0,),
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
        const SizedBox(width: 8, height: 0,),
      ],
    );
  }
}
