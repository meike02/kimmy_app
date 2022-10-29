
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kimmy/core/utils/extensions.dart';

class _TopBackClipper extends CustomClipper<Path> {
  final double _yOffset;
  final double _clipWidth;
  final double _clipHeight;
  final double _borderRadius;
  _TopBackClipper({
    required double yOffset,
    required double clipWidth,
    required double clipHeight,
    required double borderRadius})
      :_yOffset = yOffset ,
        _clipWidth = clipWidth,
        _clipHeight = clipHeight,
        _borderRadius = borderRadius;

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height / 2 + 0.1 );
    path.lineTo(size.width / 2 - _clipWidth / 2, size.height / 2 + 0.1);
    path.lineTo(size.width / 2 - _clipWidth / 2,
        size.height / 2 - _clipHeight / 2 + _borderRadius + _yOffset );
    //左上角
    path.arcToPoint(Offset(size.width / 2 - _clipWidth / 2 + _borderRadius, size.height / 2 - _clipHeight / 2 + _yOffset ),
        radius: Radius.circular(_borderRadius));
    path.lineTo(size.width / 2 + _clipWidth / 2 - _borderRadius,
        size.height / 2 - _clipHeight / 2 + _yOffset );
    //右上角
    path.arcToPoint(Offset(size.width / 2 + _clipWidth / 2, size.height / 2 - _clipHeight / 2 + _borderRadius + _yOffset ),
        radius: Radius.circular(_borderRadius));
    path.lineTo(size.width / 2 + _clipWidth / 2, size.height / 2 + 0.1);
    path.lineTo(size.width, size.height / 2 + 0.1);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class _BottomBackClipper extends CustomClipper<Path> {
  final double _yOffset;
  final double _clipWidth;
  final double _clipHeight;
  final double _borderRadius;

  _BottomBackClipper({
    required double yOffset,
    required double clipWidth,
    required double clipHeight,
    required double borderRadius })
      :_yOffset = yOffset,
        _clipWidth = clipWidth,
        _clipHeight = clipHeight ,
        _borderRadius = borderRadius;

  @override
  Path getClip(Size size) {
    var path = Path();
    print(size);

    path.moveTo(0, size.height / 2);
    path.lineTo(size.width / 2 - _clipWidth / 2, size.height / 2 );
    path.lineTo(size.width / 2 - _clipWidth / 2,
        size.height / 2 + _clipHeight / 2 - _borderRadius + _yOffset );
    //左下角
    path.arcToPoint(Offset(size.width / 2 - _clipWidth / 2 + _borderRadius, size.height / 2 + _clipHeight / 2 + _yOffset ),
        radius: Radius.circular(_borderRadius), clockwise: false);
    path.lineTo(size.width / 2 + _clipWidth / 2 - _borderRadius,
        size.height / 2 + _clipHeight / 2 + _yOffset );
    //右下角
    path.arcToPoint(Offset(size.width / 2 + _clipWidth / 2, size.height / 2 + _clipHeight / 2 - _borderRadius + _yOffset ),
        radius: Radius.circular(_borderRadius), clockwise: false);
    path.lineTo(size.width / 2 + _clipWidth / 2, size.height / 2);
    path.lineTo(size.width, size.height/2);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ShadowClipper extends StatelessWidget {
  final double yOffset;
  final double boundWidth;
  final double boundHeight;
  final double borderRadius;
  final Color backgroundColor;
  const ShadowClipper({Key? key,this.yOffset = 0, this.boundHeight = 100, this.boundWidth = 100, this.borderRadius = 8, this.backgroundColor = Colors.lightBlueAccent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottom = MediaQuery.of(context).padding.bottom;
    final top = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipPath(
            clipper: _TopBackClipper(yOffset: yOffset,clipWidth: boundWidth, clipHeight: boundHeight, borderRadius: borderRadius),
            child: Container(
                margin:
                EdgeInsets.only(top: size.height/2 + yOffset - boundHeight/2 ,left: 14, right: 14, bottom: size.height/2 - yOffset - boundHeight/2),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 4,
                        offset: Offset(0,0.5),
                        color: Color.fromARGB(16, 0, 0, 0),
                        blurRadius: 4
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                )).sized(
              height: boundHeight,
              width: boundWidth,),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipPath(
            clipper: _BottomBackClipper(yOffset:yOffset,clipWidth: boundWidth, clipHeight: boundHeight, borderRadius: borderRadius),
            child: Container(
                margin:
                EdgeInsets.only(top: size.height/2 + yOffset - boundHeight/2 ,left: 14, right: 14, bottom: size.height/2 - yOffset - boundHeight/2),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 4,
                        offset: Offset(0,0.5),
                        color: Color.fromARGB(16, 0, 0, 0),
                        blurRadius: 4
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                )).sized(
              height: boundHeight,
              width: boundWidth,),
          ),
        ),
      ],
    );
  }
}