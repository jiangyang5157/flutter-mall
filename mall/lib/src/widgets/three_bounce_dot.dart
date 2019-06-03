import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:mall/src/widgets/widgets.dart';

class ThreeBounceDot extends StatefulWidget {
  ThreeBounceDot(
      {Key key,
      this.shape = BoxShape.circle,
      this.duration = const Duration(milliseconds: 1000),
      this.size = 16.0,
      this.color_1 = Colors.red,
      this.color_2 = Colors.green,
      this.color_3 = Colors.blue,
      this.padding = const EdgeInsets.all(4),
      this.bounce = -48.0})
      : super(key: key);

  final BoxShape shape;
  final Duration duration;
  final double size;
  final Color color_1;
  final Color color_2;
  final Color color_3;
  final EdgeInsetsGeometry padding;
  final double bounce;

  @override
  _ThreeBounceDotState createState() => _ThreeBounceDotState();
}

class _ThreeBounceDotState extends State<ThreeBounceDot>
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
    _anim_1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Interval(0.0, 0.8, curve: Curves.ease),
      ),
    );
    _anim_2 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Interval(0.1, 0.9, curve: Curves.ease),
      ),
    );
    _anim_3 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Interval(0.2, 1.0, curve: Curves.ease),
      ),
    );

    _animController.addListener(() {
      setState(() => {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Transform.translate(
            offset: Offset(
              0.0,
              widget.bounce *
                  (_anim_1.value <= 0.5
                      ? _anim_1.value
                      : 1.0 - _anim_1.value),
            ),
            child: Padding(
              padding: widget.padding,
              child: Dot(
                shape: widget.shape,
                size: widget.size,
                color: widget.color_1,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(
              0.0,
              widget.bounce *
                  (_anim_2.value <= 0.5
                      ? _anim_2.value
                      : 1.0 - _anim_2.value),
            ),
            child: Padding(
              padding: widget.padding,
              child: Dot(
                shape: widget.shape,
                size: widget.size,
                color: widget.color_2,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(
              0.0,
              widget.bounce *
                  (_anim_3.value <= 0.5
                      ? _anim_3.value
                      : 1.0 - _anim_3.value),
            ),
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
