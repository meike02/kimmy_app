import 'package:flutter/cupertino.dart';

class NavigationItemInfo {
  NavigationItemInfo({
    required this.name,
    required this.page,
    required this.icon
});

  String name;
  Widget page;
  IconData icon;
}