import 'package:flutter/material.dart';
import 'dart:async';

enum ProgressButtonState { Initial, Process, Terminal }

class ProgressButton extends StatefulWidget {
  final Color color;
  final Color textColor;
  final String text;
  final Function callback;

  ProgressButton({
    Key key,
    this.text = 'Click Me',
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.callback,
  }) : super(key: key);

  @override
  _ProgressButtonState createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  Animation _animation;
  AnimationController _controller;
  GlobalKey _globalKey = GlobalKey();
  double _width = double.infinity;
  int _state = 0;
  bool _isPressed = false;
  bool _animatingReveal = false;

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
    _width = double.infinity;
    _animatingReveal = false;
    _state = 0;
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
        color: widget.color,
        elevation: calculateElevation(),
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
          key: _globalKey,
          height: 48.0,
          width: _width,
          child: RaisedButton(
            padding: EdgeInsets.all(0.0),
            color: _state == 2 ? Colors.green : widget.color,
            child: buildButtonChild(),
            onPressed: () {
              setState(() {
                if (_state == 0) {
                  animateButton();
                }
              });
            },
          ),
        ));
  }

  void animateButton() {
    double initialWidth = _globalKey.currentContext.size.width;

    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - 48.0) * _animation.value);
        });
      });
    _controller.forward();

    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        _state = 2;
      });
    });

    Timer(Duration(milliseconds: 3600), () {
      _animatingReveal = true;
      widget.callback();
    });
  }

  Widget buildButtonChild() {
    if (_state == 0) {
      return Text(
        'Login',
        style: TextStyle(color: widget.textColor, fontSize: 16.0),
      );
    } else if (_state == 1) {
      return SizedBox(
        height: 36.0,
        width: 36.0,
        child: CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(widget.textColor),
        ),
      );
    } else {
      return Icon(Icons.check, color: widget.textColor);
    }
  }

  double calculateElevation() {
    if (_animatingReveal) {
      return 0.0;
    } else {
      return _isPressed ? 6.0 : 4.0;
    }
  }
}
