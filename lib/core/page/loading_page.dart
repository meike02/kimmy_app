import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:kimmy/core/data/box_controller.dart';

class LoadingPage<T extends BoxController> extends StatefulWidget {
  LoadingPage(
      {super.key, required this.child});

  final Widget child;
  final BoxController controller = Get.find<T>();

  @override
  State<StatefulWidget> createState() {
    return _LoadingPageState();
  }
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController ;


  @override
  initState(){
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 180),
        reverseDuration: const Duration(milliseconds: 3000),
        lowerBound: 0.0,
        upperBound: 1.0,
        ///绑定页面的Ticker
        vsync: this);
    widget.controller.addListener(initListener);

    super.initState();
  }

  initListener() {
    if(widget.controller.initialized){
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.controller.initialized){
      widget.controller.removeListener(initListener);
    }
    _animationController.forward();
    return Visibility(
      visible: !widget.controller.initialized,
      replacement: FadeTransition(
        opacity: _animationController,
        child: widget.child,
      ),
      child: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SpinKitFadingCube(color: Colors.white60,size: 14,),
              Container(width: 16),
              const Text("正在加载")
            ],
          ),
        ),
      ),
    );
  }
}
