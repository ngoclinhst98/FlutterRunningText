import 'package:flutter/material.dart';
import 'package:running_text/src/controller.dart';
import 'package:running_text/src/model.dart';

/* Running Text widget with data
RunningTextView(
  data: RunningTextModel([
    "Learn how to find target keywords",
    "Learn how to find target keywords for any page with our keyword research guide."
  ])
)*/

class RunningTextView extends StatefulWidget {
  const RunningTextView({super.key, required this.data});

  final RunningTextModel
      data; // Data options for list content, text style, velocity, ...

  @override
  State<RunningTextView> createState() => _RunningTextViewState();
}

class _RunningTextViewState extends State<RunningTextView>
    with TickerProviderStateMixin {
  late final RunningTextController _controller =
      RunningTextController(widget.data); // Running text controller
  late AnimationController _animationController; // Animation controller
  late Animation<double> _animation; // Animation double
  Function(AnimationStatus)? statusListener; // Function status listener
  int _currentTextIndex = 0; // Index of current text content

  @override
  void initState() {
    super.initState();
    _controller.textStyleProcessing(); // Text style processing
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use LayoutBuilder to get the maximum width of the current widget
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        _controller.textWidthProcessing(_currentTextIndex, context);
        final double widgetMaxWidth = constraints.maxWidth;
        final double fadeWidth = widgetMaxWidth / 20;
        final (double, double) point = _controller.getPoint(widgetMaxWidth);
        final int time = _controller.getTime(widgetMaxWidth);
        _animationController = AnimationController(
            vsync: this, duration: Duration(microseconds: time));
        _animationController.forward();
        if (statusListener != null) {
          _animation.removeStatusListener(statusListener!);
        }
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

  // Function listen status
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
