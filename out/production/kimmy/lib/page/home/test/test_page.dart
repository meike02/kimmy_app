import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kimmy/core/component/shadow_clipper/cliper.dart';

class TestPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottom = MediaQuery.of(context).padding.bottom;
    final top = MediaQuery.of(context).padding.top;
    return Scaffold(
      // body: ClipCenter(
      //   borderRadius: 16,
      //   boundWidth: size.width - 14*2,
      //   boundHeight: 46,
      //   yOffset: (size.height-top)/2 - bottom - 16,
      // ),
    );
  }

}