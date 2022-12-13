import 'package:flutter/cupertino.dart';
import 'package:kimmy/core/component/notification/notice_container.dart';
import 'package:kimmy/core/utils/extensions.dart';
class TextNotice extends StatelessWidget{
  const TextNotice({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text).editProp(fontSize: 13);
  }
}