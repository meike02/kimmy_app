import 'package:flutter/material.dart';
import 'circle_painter.dart';

/// This [CircleChart] chart widget kind of StatefulWidget widget that create animated
/// circle chart.
class CircleChart extends StatefulWidget {
  final double progressNumber;
  final int maxNumber;
  final double width;
  final double height;
  final Duration animationDuration;
  final Color? progressColor;
  final Color? backgroundColor;

  /// The [CirclePainter] constructor has two required parameters that are [progressNumber] and
  /// [maxNumber]. Also have some default parameter and optional parameters.
  CircleChart(
      {required this.progressNumber,
        required this.maxNumber,
        this.animationDuration = const Duration(seconds: 1),
        this.backgroundColor,
        this.progressColor,
        this.width = 128,
        this.height = 128}) {
    assert(progressNumber > 0 && maxNumber > 0 && progressNumber < maxNumber);
  }

  @override
  State<StatefulWidget> createState() => _CircleChartState();
}

/// This [_CircleChartState] class k'nd of class that handle animation and state of [CircleChart] widget.
class _CircleChartState extends State<CircleChart>
    with SingleTickerProviderStateMixin {
  late CirclePainter _painter;
  late Animation<double> _animation;
  late AnimationController _controller;
  double _fraction = 0.0;

  /// Animation controller and animation initialized in this method called [initState]
  initState() {
    super.initState();
    _controller =
        AnimationController(duration: widget.animationDuration, vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      });
    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  MediaQueryData get media => MediaQuery.of(context);

  @override
  Widget build(BuildContext context) {
    /// [CirclePainter] object created here for using as painter.
    _painter = CirclePainter(
        animation: _controller,
        fraction: _fraction,
        progressNumber: widget.progressNumber,
        maxNumber: widget.maxNumber,
        backgroundColor: widget.backgroundColor,
        progressColor: widget.progressColor);
    return Container(
      alignment: Alignment.center,
      width: widget.width,
      height: widget.height,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return CustomPaint(painter: _painter);
          },
        ),
      ),
    );
  }
}