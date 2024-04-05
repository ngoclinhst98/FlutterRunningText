import 'package:flutter/material.dart';
import 'package:running_text/src/model.dart';

class RunningTextController {
  RunningTextModel runningTextData;

  RunningTextController(this.runningTextData);

  double currentTextWidth = 0;

  textStyleProcessing() {
    TextStyle textStyle = runningTextData.textStyle ??
        const TextStyle(overflow: TextOverflow.visible);
    if (textStyle.fontSize == null) {
      textStyle = textStyle.copyWith(fontSize: 16);
    }

    runningTextData.textStyle = textStyle;
  }

  textWidthProcessing(int index, BuildContext context) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: getTextAt(index),
            style: runningTextData.textStyle),
        textDirection: TextDirection.ltr,
    )
      ..layout(minWidth: 0, maxWidth: double.infinity);
    currentTextWidth = textPainter.width;
  }

  int getTime(double widgetMaxWidth) {
    final double distance = widgetMaxWidth > currentTextWidth
        ? widgetMaxWidth
        : currentTextWidth;

    return (distance / runningTextData.velocity * 1000000).ceil();
  }

  (double, double) getPoint(double widgetMaxWidth) {
    switch (runningTextData.direction) {
      case RunningTextDirection.leftToRight:
        return (-currentTextWidth + (currentTextWidth / 10), widgetMaxWidth);
      case RunningTextDirection.rightToLeft:
        return (widgetMaxWidth, -currentTextWidth);
    }
  }

  String getTextAt(int index) {
    return runningTextData.texts.elementAtOrNull(index) ?? "";
  }

  ShaderMask makeFade(double widgetMaxWidth, double fadeWidth, Widget child) {
    switch (runningTextData.fadeSide) {
      case RunningTextFadeSide.both:
        ShaderMask shaderMaskLeft = _getShaderMask(
            RunningTextDirection.leftToRight,
            const Offset(0, 0),
            Offset(fadeWidth, 0),
            child);
        ShaderMask shaderMaskRight = _getShaderMask(
            RunningTextDirection.rightToLeft,
            Offset(widgetMaxWidth - fadeWidth, 0),
            Offset(widgetMaxWidth, 0),
            shaderMaskLeft);
        return shaderMaskRight;
      case RunningTextFadeSide.left:
        return _getShaderMask(RunningTextDirection.leftToRight,
            const Offset(0, 0), Offset(fadeWidth, 0), child);
      case RunningTextFadeSide.right:
        return _getShaderMask(
            RunningTextDirection.rightToLeft,
            Offset(widgetMaxWidth - fadeWidth, 0),
            Offset(widgetMaxWidth, 0),
            child);
    }
  }

  ShaderMask _getShaderMask(RunningTextDirection direction, Offset beginPoint,
      Offset endPoint,
      [Widget? child]) {
    (Alignment, Alignment) alignment = _getLinearGradientAlignment(direction);
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: alignment.$1,
          end: alignment.$2,
          colors: [
            Colors.white.withOpacity(0.1),
            runningTextData.textStyle?.color ?? Colors.white
          ],
        ).createShader(Rect.fromPoints(beginPoint, endPoint));
      },
      child: child,
    );
  }

  (Alignment, Alignment) _getLinearGradientAlignment(
      RunningTextDirection direction) {
    switch (direction) {
      case RunningTextDirection.leftToRight:
        return (Alignment.centerLeft, Alignment.centerRight);
      case RunningTextDirection.rightToLeft:
        return (Alignment.centerRight, Alignment.centerLeft);
    }
  }
}
