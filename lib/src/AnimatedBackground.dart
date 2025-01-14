import 'dart:async';

import 'package:animated_background_view/src/glare/GlaresPainter.dart';
import 'package:flutter/material.dart';

import 'movingGlare/MovingGlarePainter.dart';

enum BackgroundType {
  glares,
  movingGlares
}

class AnimatedBackground extends StatefulWidget {

  final int fps;
  final BackgroundType type;
  final int glareCount;
  final double glareSize;
  final List<Color> glareColors;

  const AnimatedBackground({
    super.key,
    required this.fps,
    required this.type,
    required this.glareCount,
    required this.glareSize,
    required this.glareColors,
  });

  @override
  State<StatefulWidget> createState() => _AnimatedBackgroundState();

}

class _AnimatedBackgroundState extends State<AnimatedBackground>{

  late Timer _timer;

  late CustomPainter _painter;

  final ValueNotifier<bool> _shouldRepaint = ValueNotifier<bool>(true);

  Orientation? _lastOrientation;

  @override
  void initState() {
    super.initState();

    _painter = switch(widget.type){
      BackgroundType.glares => GlaresPainter(
        repaint: _shouldRepaint,
        colors: widget.glareColors,
        glareCount: widget.glareCount,
        glareSize: widget.glareSize,
      ),
      BackgroundType.movingGlares => MovingGlarePainter(
        repaint: _shouldRepaint,
        colors: widget.glareColors,
        glareCount: widget.glareCount,
        glareSize: widget.glareSize,
      )
    };

    _timer = Timer.periodic(Duration(milliseconds: 1000~/widget.fps), (Timer timer) {
      _shouldRepaint.value = !_shouldRepaint.value;
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