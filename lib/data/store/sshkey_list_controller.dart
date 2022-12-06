import 'dart:convert';

import 'package:kimmy/core/data/box_controller.dart';

import '../model/sshkey_info.dart';

class SSHKeyListController extends BoxController<SSHKeyInfo>{
  SSHKeyListController() : super();
  bool editing = false;
}