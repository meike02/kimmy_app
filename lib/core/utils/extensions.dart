import 'dart:ui';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kimmy/core/data/box_controller.dart';
import 'package:kimmy/core/page/loading_page.dart';

import 'global_props.dart';

extension WidgetExt on Widget {
  Container intoContainer({
    //复制Container构造函数的所有参数（除了child字段）
    Key? key,
    AlignmentGeometry? alignment,
    EdgeInsetsGeometry? padding,
    Color? color,
    Decoration? decoration,
    Decoration? foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? margin,
    Matrix4? transform,
  }) {
    //调用Container的构造函数，并将当前widget对象作为child参数
    return Container(
      key: key,
      alignment: alignment,
      padding: padding,
      color: color,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      transform: transform,
      child: this,
    );
  }

  GestureDetector loseFocus(BuildContext context) {
    return GestureDetector(
        // behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        onPanCancel: () => FocusScope.of(context).requestFocus(FocusNode()),
        onTapCancel: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: WillPopScope(
          child: this,
          onWillPop: () {
            FocusScope.of(context).requestFocus(FocusNode());
            return Future.value(true);
          },
        ));
  }

  // GestureDetector onTap(Function tap) {
  //   return GestureDetector(
  //       //HitTestBehavior.translucent position在自己的范围内，都会消费事件
  //       behavior: HitTestBehavior.translucent,
  //       onTap: () => tap,
  //       child: this);
  // }

  InkWell intoInkWell({Key? key, void Function()? onTap, bool overlay = true}) {
    return InkWell(
      key: key,
      onTap: onTap,
      overlayColor:
          overlay ? MaterialStateProperty.all(Colors.transparent) : null,
      highlightColor: overlay ? Colors.transparent : null,
      child: this,
    );
  }

  ClipRRect intoBlurClip(BuildContext context,
      {double? radius, double? blur, double? width}) {
    // var props = Props(context);
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(98, 20, 20, 20)
            : Colors.white.withOpacity(0.24),
        width: width,
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: blur ?? 34,
              sigmaY: blur ?? 34,
              tileMode: TileMode.repeated),
          child: this,
        ),
      ),
    );
  }

  Center containedByCenter() {
    return Center(
      child: this,
    );
  }

  AnimatedContainer withAnimation({
    Key? key,
    AlignmentGeometry? alignment,
    EdgeInsetsGeometry? padding,
    Color? color,
    Decoration? decoration,
    Decoration? foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? margin,
    Matrix4? transform,
    required Duration duration,
    Curve? curve,
    Clip? clip,
    Function()? onEnd,
  }) {
    return AnimatedContainer(
      key: key,
      alignment: alignment,
      padding: padding,
      color: color,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      transform: transform,
      duration: duration,
      curve: curve ?? Curves.linear,
      clipBehavior: clip ?? Clip.none,
      onEnd: onEnd,
      child: this,
    );
  }

  SizedBox sized({
    Key? key,
    double? width,
    double? height,
  }) {
    return SizedBox(
      key: key,
      width: width,
      height: height,
      child: this,
    );
  }

  Expanded intoExpanded() {
    return Expanded(child: this);
  }

  WillPopScope onReturn(Future<bool> Function() fun) {
    return WillPopScope(child: this, onWillPop: fun);
  }

  GestureDetector intoGestureDetector({
    void Function()? onTap,
    void Function()? onLongPress,
    void Function(TapDownDetails)? onTapDown,
  }) {
    return GestureDetector(
      child: this,
      onTapDown: onTapDown,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }

  SafeArea intoSafeArea(){
    return SafeArea(child: this);
  }

  LoadingPage<T> intoLoadingPage<T extends BoxController>() {
    return LoadingPage<T>(child: this);
  }
}

extension WidgetExt2 on Widget {
  //添加一个相邻的widget，返回List<Widget>
  List<Widget> addNeighbor(Widget widget) {
    return <Widget>[this, widget];
  }

//添加各种单child的widget容器
//如:Container、Padding等...
}

extension WidgetListExt<T extends Widget> on List<T> {
  //子List<Widget>列表中再添加一个相邻的widget，并返回当前列表
  List<Widget> addNeighbor(T widget) {
    return this..add(widget);
  }

  Row intoRow({
    Key? key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
  }) {
    return Row(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: this,
    );
  }

//添加其它多child的widget容器
//如:Column、ListView等...
}

extension CenterExt on Center {
  Center addChild({required String text}) {
    return Center(
      child: Text(text),
    );
  }
}

extension TextExt on Text {
  Text importStyle({required TextStyle style}) {
    return Text(data!, style: style);
  }

  Text editProp({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    TextOverflow? overflow,
  }) {
    TextStyle? ts = style == null
        ? TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: fontFamily,
            overflow: overflow,
          )
        : style!.copyWith(color: color, fontSize: fontSize);

    return Text(
      data!,
      style: ts,
    );
  }

  Text inCupertino(BuildContext context) {
    TextStyle? ts = style == null
        ? TextStyle(color: CupertinoTheme.of(context).textTheme.textStyle.color)
        : style!.copyWith(
            color: CupertinoTheme.of(context).textTheme.textStyle.color);
    return Text(
      data!,
      style: ts,
    );
  }
}

extension CupertinoTextFieldExt on CupertinoTextField {
  CupertinoTextField inCupertino(BuildContext context) {
    BoxDecoration? bd = decoration == null
        ? BoxDecoration(
            color: CupertinoTheme.brightnessOf(context) == Brightness.dark
                ? const Color.fromRGBO(255, 255, 255, 0.085)
                : const Color.fromRGBO(0, 0, 0, 0.085))
        : decoration!.copyWith(
            color: CupertinoTheme.brightnessOf(context) == Brightness.dark
                ? const Color.fromRGBO(255, 255, 255, 0.085)
                : const Color.fromRGBO(0, 0, 0, 0.085));

    return CupertinoTextField(
      placeholder: placeholder,
      decoration: bd,
      onChanged: onChanged,
    );
  }
}

extension ColorExt on Color {
  Color getBrighterBgcolor(BuildContext context, {double? opacity}) {
    return Color.lerp(Theme.of(context).scaffoldBackgroundColor, Colors.white,
            isDark(context) ? opacity ?? 0.09 : ((opacity ?? 0.09) + 0.75))!
        .withOpacity(1);
  }

  Color editOpacity(double newOpacity) {
    final newColor = Color.fromRGBO(red, green, blue, newOpacity);
    return newColor;
  }
}

extension StringExt on String {
  Uri toUri() {
    var routingData = Uri.parse(this);
    return routingData;
  }

  String killBlankSpace() {
    return replaceAll(RegExp(r"\s+\b|\b\s"), "");
  }
}

// extension CustomBotToast on BotToast {
//   static CancelFunc showText(BuildContext context, String mes) {
//     return BotToast.showCustomText(
//         toastBuilder: (_) => ClipRRect(
//             borderRadius: const BorderRadius.all(Radius.circular(10)),
//             child: Container(
//               color: toastColor(context),
//               padding: const EdgeInsets.all(10),
//               child: Text(mes,
//                   style: TextStyle(
//                       color: isDark(context)
//                           ? const Color.fromARGB(255, 225, 225, 225)
//                           : const Color.fromARGB(255, 22, 22, 22))),
//             )));
//   }

  // static void Function() showConfirmDialog(
  //   BuildContext context, {
  //   required String message,
  //   double height = 160,
  //   double width = 240,
  //   void Function()? onConfirm,
  // }) {
  //   return BotToast.showAnimationWidget(
  //       backgroundColor: Colors.black26,
  //       clickClose: true,
  //       allowClick: false,
  //       toastBuilder: (closeFunc) {
  //         return Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Expanded(flex: 8, child: Text(message).containedByCenter()),
  //             const Divider(),
  //             Expanded(
  //                 flex: 3,
  //                 child: Row(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     TextButton(
  //                       style: ButtonStyle(
  //                           overlayColor:
  //                               MaterialStateProperty.all(Colors.transparent),
  //                           foregroundColor: MaterialStateProperty.all(
  //                               isDark(context) ? Colors.white : Colors.black),
  //                           minimumSize: MaterialStateProperty.all(
  //                               Size(width / 2 - 10, 54))),
  //                       onPressed: closeFunc,
  //                       child: const Text("取消"),
  //                     ),
  //                     const VerticalDivider(),
  //                     TextButton(
  //                       style: ButtonStyle(
  //                           overlayColor:
  //                               MaterialStateProperty.all(Colors.transparent),
  //                           foregroundColor:
  //                               MaterialStateProperty.all(Colors.red),
  //                           minimumSize: MaterialStateProperty.all(
  //                               Size(width / 2 - 10, 54))),
  //                       onPressed: () {
  //                         onConfirm?.call();
  //                         closeFunc.call();
  //                       },
  //                       child: const Text("确认"),
  //                     )
  //                   ],
  //                 ))
  //           ],
  //         )
  //             .intoContainer(
  //                 height: height,
  //                 width: width,
  //                 padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(6),
  //                   color: toastColor(context),
  //                 ))
  //             .containedByCenter();
  //       },
  //       wrapAnimation: (AnimationController animation, _, child) {
  //         return FadeTransition(
  //           opacity: animation.view,
  //           child: child,
  //         );
  //       },
  //       animationDuration: const Duration(milliseconds: 200));
  // }

//   static void Function() showCustomDialog(
//     BuildContext context, {
//     required Widget child,
//     void Function()? onConfirm,
//   }) {
//     return BotToast.showAnimationWidget(
//         backgroundColor: Colors.black26,
//         clickClose: true,
//         allowClick: false,
//         toastBuilder: (closeFunc) {
//           return child.containedByCenter();
//         },
//         wrapAnimation: (AnimationController animation, _, child) {
//           return FadeTransition(
//             opacity: animation.view,
//             child: child,
//           );
//         },
//         animationDuration: const Duration(milliseconds: 200));
//   }
// }

extension IntExt on int {
  String toChineseWeekdayName() {
    late String weekdayName;
    switch (this) {
      case 1:
        {
          weekdayName = "一";
        }
        break;
      case 2:
        {
          weekdayName = "二";
        }
        break;
      case 3:
        {
          weekdayName = "三";
        }
        break;
      case 4:
        {
          weekdayName = "四";
        }
        break;
      case 5:
        {
          weekdayName = "五";
        }
        break;
      case 6:
        {
          weekdayName = "六";
        }
        break;
      case 7:
        {
          weekdayName = "日";
        }
        break;
      default:
        {
          weekdayName = "";
        }
        break;
    }
    return weekdayName;
  }
}

extension DateTimeExt on DateTime {
  String convertToString({bool isAccurate = false, DateTime? dateTime}) {
    DateTime now = dateTime ?? DateTime.now();
    var time = this;
    var years = now.year - time.year;
    var days = now.day - time.day;
    var resultString = "";
    if (years > 0) {
      resultString = formatDate(time, [yyyy, "年", mm, "月", dd, "号 "]);
    } else if (days > 6) {
      resultString = "${time.month}月${time.day}号";
    } else if (days > 1) {
      String weekdayName = time.weekday.toChineseWeekdayName();
      resultString = "周$weekdayName";
    } else if (days > 0) {
      resultString = "昨天";
    } else {
      resultString = "${periodName()}${formatDate(time, ["h", ":", "nn"])}";
    }

    if (isAccurate && (days > 0 || years > 0)) {
      resultString += " ${periodName()}${formatDate(time, ["h", ":", "nn"])}";
    }
    return resultString;
  }

  String periodName() {
    final time = this;
    String periodName = "";
    var hour = time.hour;
    if (hour < 6) {
      periodName = "凌晨";
    } else if (hour < 9) {
      periodName = "早晨";
    } else if (hour < 12) {
      periodName = "上午";
    } else if (hour < 13) {
      periodName = "中午";
    } else if (hour < 18) {
      periodName = "下午";
    } else {
      periodName = "晚上";
    }
    return periodName;
  }
}
