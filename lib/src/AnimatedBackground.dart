import 'dart:async';
import 'package:animated_background_view/src/glare/GlaresPainter.dart';
import 'package:animated_background_view/src/movingGlare/MovingGlarePainter.dart';
import 'package:animated_background_view/src/squares/SquaresPainter.dart';
import 'package:animated_background_view/src/circles/CirclesPainter.dart';
import 'package:flutter/material.dart';

import 'utils/BackgroundPainter.dart';


enum BackgroundType {
  glares,
  movingGlares,
  circles,
  squares
}

class AnimatedBackground extends StatefulWidget {

  final int fps;
  final BackgroundType type;
  final int glareCount;
  final double glareSize;
  final List<Color> colors;
  final bool blur;
  final double blurAmount;
  final bool shadows;

  const AnimatedBackground({
    super.key,
    this.fps = 60,
    this.type = BackgroundType.movingGlares,
    this.glareCount = 24,
    this.glareSize = 48,
    this.colors = const <Color>[
      Color(0xfffacbc1),
      Color(0xffef6f42),
      Color(0xfff1ad4c),
      Color(0xffab5021),
      Color(0xffefbc3f),
      Color(0xfff37656)
    ],
    this.blur = true,
    this.blurAmount = 12,
    this.shadows = true,
  });

  @override
  State<StatefulWidget> createState() => _AnimatedBackgroundState();

}

class _AnimatedBackgroundState extends State<AnimatedBackground>{

  late Timer _timer;

  late BackgroundPainter _painter;

  final ValueNotifier<bool> _shouldRepaint = ValueNotifier<bool>(true);

  Orientation? _lastOrientation;

  @override
  void initState() {
    super.initState();

    _createPainter();

    _timer = Timer.periodic(Duration(milliseconds: 1000~/widget.fps), (Timer timer) {
      _shouldRepaint.value = !_shouldRepaint.value;
    });

  }

  void _createPainter(){
    _painter = switch(widget.type){
      BackgroundType.glares => GlaresPainter(
        repaint: _shouldRepaint,
        colors: widget.colors,
        glareCount: widget.glareCount,
        glareSize: widget.glareSize,
        enableBlur: widget.blur,
        blurAmount: widget.blurAmount,
      ),
      BackgroundType.movingGlares => MovingGlarePainter(
        repaint: _shouldRepaint,
        colors: widget.colors,
        glareCount: widget.glareCount,
        glareSize: widget.glareSize,
        enableBlur: widget.blur,
        blurAmount: widget.blurAmount,
      ),
      BackgroundType.circles => CirclesPainter(
        repaint: _shouldRepaint,
        colors: widget.colors,
        shadows: widget.shadows,
        enableBlur: widget.blur,
        blurAmount: widget.blurAmount
      ),
      BackgroundType.squares => SquaresPainter(
        repaint: _shouldRepaint,
        colors: widget.colors,
        shadows: widget.shadows,
        enableBlur: widget.blur,
        blurAmount: widget.blurAmount
      ),
    };
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void didUpdateWidget(AnimatedBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.type != oldWidget.type || widget.blur != oldWidget.blur){
      _createPainter();
    }
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