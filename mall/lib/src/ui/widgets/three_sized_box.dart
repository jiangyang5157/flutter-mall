import 'dart:math' as math show sin, pi;
import 'package:flutter/widgets.dart';

class ThreeSizedBox extends StatefulWidget {
  ThreeSizedBox({
    Key key,
    this.widgetBuilder,
    this.size = 40.0,
    this.duration = const Duration(milliseconds: 1200),
  })  : assert(widgetBuilder != null),
        assert(size != null),
        assert(duration != null),
        super(key: key);

  final double size;
  final IndexedWidgetBuilder widgetBuilder;
  final Duration duration;

  @override
  _ThreeSizeBoxState createState() => _ThreeSizeBoxState();
}

class _ThreeSizeBoxState extends State<ThreeSizedBox>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: widget.duration)..repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size(widget.size * 2, widget.size),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _box(0, 0.0),
            _box(1, 0.2),
            _box(2, 0.4),
          ],
        ),
      ),
    );
  }

  Widget _box(int index, double delay) {
    final _size = widget.size * 0.5;
    return ScaleTransition(
      scale: DelayTween(begin: 0.0, end: 1.0, delay: delay)
          .animate(animationController),
      child: SizedBox.fromSize(
        size: Size.square(_size),
        child: widget.widgetBuilder(context, index),
      ),
    );
  }
}

class DelayTween extends Tween<double> {
  DelayTween({
    double begin,
    double end,
    this.delay,
  }) : super(begin: begin, end: end);

  final double delay;

  @override
  double lerp(double t) =>
      super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
