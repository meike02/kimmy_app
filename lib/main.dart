import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kimmy/page/home/home.dart';
import 'package:path_provider/path_provider.dart';

import 'data/store/server_list_controller.dart';
import 'data/store/sshkey_list_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationSupportDirectory();
  Hive.init(directory.path);
  Get.put<SSHKeyListController>(SSHKeyListController());
  Get.put<ServerListController>(ServerListController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'kimmy',
      builder: BotToastInit(), //1.调用BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
      home: Home(),
      theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: const Color(0xFF00848c))),
      darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF00848c), brightness: Brightness.dark),
      ),
    );
  }
}
