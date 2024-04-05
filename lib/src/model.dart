import 'package:flutter/material.dart';

class RunningTextModel {
  List<String> texts;
  TextStyle? textStyle;
  double velocity;
  RunningTextDirection direction;
  RunningTextFadeSide fadeSide;

  RunningTextModel(this.texts,
      {this.textStyle,
      this.velocity = 50,
      this.direction = RunningTextDirection.rightToLeft,
      this.fadeSide = RunningTextFadeSide.both});
}

enum RunningTextDirection { leftToRight, rightToLeft }

enum RunningTextFadeSide { left, right, both }
