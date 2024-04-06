import 'package:flutter/material.dart';

class RunningTextModel {
  List<String> texts; // The text list content will run
  TextStyle? textStyle; // The text style for content
  double velocity; // Running text velocity
  RunningTextDirection direction; // Running direction
  RunningTextFadeSide fadeSide; // The edges of the Running Text will be blurred

  RunningTextModel(this.texts,
      {this.textStyle,
      this.velocity = 50,
      this.direction = RunningTextDirection.rightToLeft,
      this.fadeSide = RunningTextFadeSide.both});
}

// Direction of movement of Running Text
enum RunningTextDirection {
  leftToRight, // Move from left to right.
  rightToLeft // Move from right to left
}

// The edges of the Running Text will be blurred
enum RunningTextFadeSide {
  left, // The left edge of the text
  right, // The right edge of the text
  both // The both edges of the text
}
