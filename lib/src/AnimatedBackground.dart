import 'dart:async';

import 'package:animated_background_view/src/glare/GlaresPainter.dart';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {

  final int fps;

  const AnimatedBackground({super.key, required this.fps});

  @override
  State<StatefulWidget> createState() => _AnimatedBackgroundState();

}

class _AnimatedBackgroundState extends State<AnimatedBackground>{

  late Timer _timer;
  bool _notifierState = false;

  late GlaresPainter _painter;

  final ValueNotifier<bool> _shouldRepaint = ValueNotifier<bool>(true);

  Orientation? _lastOrientation;

  @override
  void initState() {
    super.initState();

    _painter = GlaresPainter(
      repaint: _shouldRepaint,
    );

    _timer = Timer.periodic(Duration(milliseconds: 1000~/widget.fps), (Timer timer) {
      setState(() {
        _notifierState = !_notifierState;
        _shouldRepaint.value = _notifierState;
      });
    });

  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _lastOrientation ??= MediaQuery.of(context).orientation;
    if (MediaQuery.of(context).orientation != _lastOrientation){
      _lastOrientation = MediaQuery.of(context).orientation;
      //_painter.handleChange();
    }

    return CustomPaint(
      painter: _painter,
      child: Container(),
    );

  }

}