import 'package:flutter/material.dart';

class TextEditingControllerWorkaround extends TextEditingController {
  TextEditingControllerWorkaround({String text}) : super(text: text);

  void setTextAndPosition(String newText, {int newPosition}) {
    int offset = newPosition != null ? newPosition : newText.length;
    value = value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: offset),
        composing: TextRange.empty);
  }
}
