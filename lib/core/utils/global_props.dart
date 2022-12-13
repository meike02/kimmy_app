import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:kimmy/core/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

//是否为深色模式
bool isDark(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

double appBarHeight(BuildContext context) =>
    MediaQuery.of(context).padding.top + 18 + appBarContentHeight;

double appBarContentHeight = 32;

Future<SharedPreferences> getPreference() => SharedPreferences.getInstance();

double bottom(context) => MediaQuery.of(context).padding.bottom;

ColorScheme colorScheme(context) => Theme.of(context).colorScheme;

showAnimationWidget(ToastBuilder builder, {required BuildContext context ,Duration? duration}) {
  final bottomPadding = bottom(context);
  BotToast.showAnimationWidget(
      toastBuilder: builder,
      wrapToastAnimation: (controller, cancelFunc, child) {
        return ScaleTransition(
          scale: controller.drive(CurveTween(curve: Curves.easeOutQuart)),
          alignment: Alignment.bottomCenter,
          child: FadeTransition(
            opacity: controller.drive(CurveTween(curve: Curves.easeOutQuart)),
            child: child,
          ),
        ).intoContainer(margin: EdgeInsets.only(bottom: bottomPadding + 60));
      },
      onlyOne: true,
      animationDuration: const Duration(milliseconds: 250),
      animationReverseDuration: const Duration(milliseconds: 250),
      duration: duration);
}

// Future<String?> selectAndUploadPictures() async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//     type: FileType.image,
//   );
//   if (result != null) {
//
//   } else {
//     //user cancled the picker
//     print('用户停止了选择图片');
//     return null;
//   }
// }
