import 'package:flutter/material.dart';

class RunningTextModel {
  /// The text list content will run
  List<String> texts;

  /// The text style for content
  TextStyle? textStyle;

  /// Running text velocity
  double velocity;

  /// Running direction
  RunningTextDirection direction;

  /// The edges of the Running Text will be blurred
  RunningTextFadeSide fadeSide;

  RunningTextModel(this.texts,
      {TextStyle? textStyle,
      this.velocity = 50,
      this.direction = RunningTextDirection.rightToLeft,
      this.fadeSide = RunningTextFadeSide.both}) {
    TextStyle textStyleTemp = textStyle ?? const TextStyle();
    if (textStyleTemp.fontSize == null) {
      textStyleTemp = textStyleTemp.copyWith(fontSize: 16);
    }

    this.textStyle = textStyleTemp;
  }
}

/// Direction of movement of Running Text
enum RunningTextDirection {
  /// Move from left to right.
  leftToRight,

  /// Move from right to left
  rightToLeft
}

/// The edges of the Running Text will be blurred
enum RunningTextFadeSide {
  /// The left edge of the text
  left,

  /// The right edge of the text
  right,

  /// The both edges of the text
  both
}
