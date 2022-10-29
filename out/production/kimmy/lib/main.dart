import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kimmy/data/store/sshkey_list_controller.dart';
import 'package:kimmy/page/home/home.dart';
import 'package:kimmy/page/server/server_edit/server_edit_page.dart';
import 'package:kimmy/page/server/sshkey/sshkey_edit_page.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationSupportDirectory();
  Hive.init(directory.path);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'kimmy',
      home: Home(),
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00848c))),
      darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xFF00848c),
            brightness: Brightness.dark
          )),
    );
  }
}