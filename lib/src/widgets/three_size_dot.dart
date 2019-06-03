import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:mall/src/widgets/widgets.dart';

class ThreeSizeDot extends StatefulWidget {
  ThreeSizeDot(
      {Key key,
      this.shape = BoxShape.circle,
      this.duration = const Duration(milliseconds: 1000),
      this.size = 16.0,
      this.color_1 = Colors.red,
      this.color_2 = Colors.green,
      this.color_3 = Colors.blue,
      this.padding = const EdgeInsets.all(4)})
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
  AnimationController _animController;
  Animation<double> _anim_1;
  Animation<double> _anim_2;
  Animation<double> _anim_3;

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animController =
        AnimationController(vsync: this, duration: widget.duration)..repeat();
    _anim_1 = DelayTween(begin: 0.0, end: 1.0, delay: 0.0)
        .animate(_animController);
    _anim_2 = DelayTween(begin: 0.0, end: 1.0, delay: 0.2)
        .animate(_animController);
    _anim_3 = DelayTween(begin: 0.0, end: 1.0, delay: 0.4)
        .animate(_animController);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ScaleTransition(
            scale: _anim_1,
            child: Padding(
              padding: widget.padding,
              child: Dot(
                shape: widget.shape,
                size: widget.size,
                color: widget.color_1,
              ),
            ),
          ),
          ScaleTransition(
            scale: _anim_2,
            child: Padding(
              padding: widget.padding,
              child: Dot(
                shape: widget.shape,
                size: widget.size,
                color: widget.color_2,
              ),
            ),
          ),
          ScaleTransition(
            scale: _anim_3,
            child: Padding(
              padding: widget.padding,
              child: Dot(
                shape: widget.shape,
                size: widget.size,
                color: widget.color_3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
