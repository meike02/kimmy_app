import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kimmy/core/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

//是否为深色模式
bool isDark(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

double appBarHeight(BuildContext context) =>
    MediaQuery.of(context).padding.top + 12 + appBarContentHeight;

double appBarContentHeight = 32;

Future<SharedPreferences> getPreference() => SharedPreferences.getInstance();

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
