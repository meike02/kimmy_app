import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kimmy/data/model/navigation_item_info.dart';
import 'package:kimmy/page/home/test/test_page.dart';
import 'package:kimmy/page/server/server_edit/server_edit_page.dart';
import 'package:kimmy/page/server/sshkey/sshkey_list_page.dart';


class NavigationBarController extends GetxController{
  final List<NavigationItemInfo> _navigationList = [
    NavigationItemInfo(
        name: "sshkey",
        page: SSHKeyListPage(),
        icon: Icons.key_rounded
    ),
    NavigationItemInfo(
        name: "server",
        page: ServerEditPage(),
        icon: Icons.computer_rounded
    ),
    NavigationItemInfo(
        name: "server",
        page: ServerEditPage(),
        icon: Icons.computer_rounded
    ),
    NavigationItemInfo(
        name: "sshkey",
        page: SSHKeyListPage(),
        icon: Icons.key_rounded
    )
  ];

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  late Widget _selectedPage;
  Widget get selectedPage => _selectedPage;
  int get length => _navigationList.length;
  List<NavigationItemInfo> get navigationList => _navigationList;

  select(int index){
    _selectedIndex = index;
    _selectedPage = _navigationList[index].page;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _selectedPage = _navigationList[selectedIndex].page;
  }

}