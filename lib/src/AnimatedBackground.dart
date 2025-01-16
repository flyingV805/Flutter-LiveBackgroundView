import 'dart:async';
import 'package:animated_background_view/src/glare/GlaresPainter.dart';
import 'package:animated_background_view/src/movingGlare/MovingGlarePainter.dart';
import 'package:animated_background_view/src/squares/SquaresPainter.dart';
import 'package:animated_background_view/src/circles/CirclesPainter.dart';
import 'package:flutter/material.dart';
import 'utils/BackgroundPainter.dart';

/// Type of rendered effect.
enum BackgroundType {
  /// Smooth glares that appear and disappear
  glares,
  /// Smooth glares that appear and disappear while moving on the screen
  movingGlares,
  /// Giant circles, moving through the screen
  circles,
  /// Giant squares, moving through the screen
  squares
}

/// This widget creates a view that provides a live effect.
/// There are several parameters for customization.
///
/// Here's what you can tweak:
/// [fps] - The number of times per second that rendering will occur
/// [type] - Type of background
/// [glareCount] - The amount of glare on the screen for 'glares' and 'movingGlares'
/// [glareSize] - The size of glare on the screen for 'glares' and 'movingGlares'
/// [colors] - Colors used for patterns for all types of effects
/// [blur] - Whether to apply blur to effects
/// [blurAmount] - Amount of blur. Ignored if [blur] is false.
/// [shadows] - Applies shadows to patterns. Works for types 'circles' and 'squares'
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