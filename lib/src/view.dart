import 'package:flutter/material.dart';
import 'package:running_text/src/controller.dart';
import 'package:running_text/src/model.dart';

/// Running Text widget with data
/// RunningTextView(
///   data: RunningTextModel([
///   "Learn how to find target keywords",
///   "Learn how to find target keywords for any page with our keyword research guide."
///   ])
/// )

class RunningTextView extends StatefulWidget {
  const RunningTextView({super.key, required this.data});

  /// Data options for list content, text style, velocity, ...
  final RunningTextModel data;

  @override
  State<RunningTextView> createState() => _RunningTextViewState();
}

class _RunningTextViewState extends State<RunningTextView>
    with TickerProviderStateMixin {
  /// Running text controller
  late final RunningTextController _controller =
      RunningTextController(widget.data);

  /// Animation controller
  late AnimationController _animationController;

  /// Animation double
  late Animation<double> _animation;

  /// Function status listener
  Function(AnimationStatus)? statusListener;

  /// Index of current text content
  int _currentTextIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Use LayoutBuilder to get the maximum width of the current widget
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double widgetMaxWidth = constraints.maxWidth;
        _controller.textWidthProcessing(
            _currentTextIndex, context, widgetMaxWidth);
        final double fadeWidth = widgetMaxWidth / 20;
        final (double, double) point = _controller.getPoint(widgetMaxWidth);
        final int time = _controller.getTime(widgetMaxWidth);
        if (statusListener != null) {
          _animationController.dispose();
          _animation.removeStatusListener(statusListener!);
        }

        _animationController = AnimationController(
            vsync: this, duration: Duration(microseconds: time));
        _animationController.forward();
        statusListener = listenStatus;

        _animation = Tween<double>(
          begin: point.$1,
          end: point.$2,
        ).animate(_animationController);

        _animation.addStatusListener(statusListener!);

        return SizedBox(
          width: widgetMaxWidth,
          child: ClipRect(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return _controller.makeFade(
                    widgetMaxWidth,
                    fadeWidth,
                    Transform.translate(
                      offset: Offset(_animation.value, 0),
                      child: Text(_controller.getTextAt(_currentTextIndex),
                          textAlign: TextAlign.start,
                          textScaler: TextScaler.noScaling,
                          textWidthBasis: TextWidthBasis.parent,
                          style: _controller.runningTextData.textStyle),
                    ));
              },
            ),
          ),
        );
      },
    );
  }

  /// Function listen status
  listenStatus(status) {
    if (status != AnimationStatus.completed) {
      return;
    }

    _currentTextIndex++;
    if (_currentTextIndex >= _controller.runningTextData.texts.length) {
      _currentTextIndex = 0;
    }
    setState(() {});
  }
}
