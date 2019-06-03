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
  double _height = 48;
  double _width = 200;
  ProgressButtonState _state = ProgressButtonState.Initial;
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
    _width = 200;
    _animatingReveal = false;
    _state = ProgressButtonState.Initial;
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
        color: widget.color,
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
          key: _globalKey,
          height: _height,
          width: _width,
          child: RaisedButton(
            padding: EdgeInsets.all(0.0),
            color: _state == ProgressButtonState.Terminal
                ? Colors.green
                : widget.color,
            child: buildButtonChild(),
            onPressed: () {
              setState(() {
                if (_state == ProgressButtonState.Initial) {
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
        AnimationController(duration: Duration(milliseconds: 250), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - _height) * _animation.value);
        });
      });
    _controller.forward();

    setState(() {
      _state = ProgressButtonState.Process;
    });

    Timer(Duration(milliseconds: 1750), () {
      setState(() {
        _state = ProgressButtonState.Terminal;
      });
    });

    Timer(Duration(milliseconds: 2000), () {
      _animatingReveal = true;
      widget.callback();
    });
  }

  Widget buildButtonChild() {
    if (_state == ProgressButtonState.Initial) {
      return Text(widget.text, style: TextStyle(color: widget.textColor));
    } else if (_state == ProgressButtonState.Process) {
      return SizedBox(
        child: CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(widget.textColor),
        ),
      );
    } else {
      return Icon(Icons.check, color: widget.textColor);
    }
  }
}
