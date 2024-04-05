import 'package:flutter/material.dart';
import 'package:running_text/src/controller.dart';
import 'package:running_text/src/model.dart';

class RunningTextView extends StatefulWidget {
  const RunningTextView({super.key, required this.data});

  final RunningTextModel data;

  @override
  State<RunningTextView> createState() => _RunningTextViewState();
}

class _RunningTextViewState extends State<RunningTextView>
    with TickerProviderStateMixin {
  late final RunningTextController _controller =
  RunningTextController(widget.data);
  late AnimationController _animationController;
  late Animation<double> _animation;
  Function(AnimationStatus)? statusListener;
  int _currentTextIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.textStyleProcessing();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
