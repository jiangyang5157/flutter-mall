import 'package:flutter/material.dart';

import 'package:mall/src/widgets/widgets.dart';

class ThreeSizeDot extends StatefulWidget {
  ThreeSizeDot(
      {Key key,
      this.shape = BoxShape.circle,
      this.duration = const Duration(milliseconds: 1000),
      this.size = 8.0,
      this.color_1,
      this.color_2,
      this.color_3,
      this.padding = const EdgeInsets.all(2)})
      : super(key: key);

  final BoxShape shape;
  final Duration duration;
  final double size;
  final Color color_1;
  final Color color_2;
  final Color color_3;
  final EdgeInsetsGeometry padding;

  @override
  _ThreeSizeDotState createState() => _ThreeSizeDotState();
}

class _ThreeSizeDotState extends State<ThreeSizeDot>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation_1;
  Animation<double> animation_2;
  Animation<double> animation_3;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: widget.duration);
    animation_1 = DelayTween(begin: 0.0, end: 1.0, delay: 0.0)
        .animate(animationController);
    animation_2 = DelayTween(begin: 0.0, end: 1.0, delay: 0.2)
        .animate(animationController);
    animation_3 = DelayTween(begin: 0.0, end: 1.0, delay: 0.4)
        .animate(animationController);
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ScaleTransition(
            scale: animation_1,
            child: Padding(
              padding: widget.padding,
              child: Dot(
                shape: widget.shape,
                size: widget.size,
                color:
                    widget.color_1 ?? Theme.of(context).textTheme.title.color,
              ),
            ),
          ),
          ScaleTransition(
            scale: animation_2,
            child: Padding(
              padding: widget.padding,
              child: Dot(
                shape: widget.shape,
                size: widget.size,
                color:
                    widget.color_2 ?? Theme.of(context).textTheme.title.color,
              ),
            ),
          ),
          ScaleTransition(
            scale: animation_3,
            child: Padding(
              padding: widget.padding,
              child: Dot(
                shape: widget.shape,
                size: widget.size,
                color:
                    widget.color_3 ?? Theme.of(context).textTheme.title.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
