import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:mall/src/core/core.dart';
import 'package:mall/src/widgets/widgets.dart';

class RevealProgressButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RevealProgressButtonState();
}

class _RevealProgressButtonState extends State<RevealProgressButton>
    with TickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  double _fraction = 0.0;

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    reset();
    super.deactivate();
  }

  void reset() {
    _fraction = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter:
          RevealProgressButtonPainter(MediaQuery.of(context).size, _fraction),
      child: ProgressButton(reveal),
    );
  }

  void reveal() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      })
      ..addStatusListener((AnimationStatus state) {
        if (state == AnimationStatus.completed) {
          // todo Fix this
          Navigation().router.navigateTo(context, 'TestPage',
              transition: TransitionType.fadeIn);
        }
      });
    _controller.forward();
  }
}
