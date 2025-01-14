import 'dart:ui';
import 'package:animated_background_view/src/utils/list.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../utils/BackgroundPainter.dart';
import '../utils/math.dart';
import 'Circle.dart';
import 'CircleListener.dart';

class CirclesPainter extends BackgroundPainter implements CircleListener {

  final Random _random = Random();
  final int _circlesCount = 6;

  final List<Color> colors;
  final bool enableBlur;
  final double blurAmount;

  final Paint _stainPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..style = PaintingStyle.fill;

  CirclesPainter({
    super.repaint,
    required this.colors,
    required this.enableBlur,
    required this.blurAmount,
  }){
    if(enableBlur){
      _stainPaint.imageFilter = ImageFilter.blur(
        sigmaX: blurAmount,
        sigmaY: blurAmount,
        tileMode: TileMode.decal
      );
    }
  }

  double _viewWidth = 0.0;
  double _viewHeight = 0.0;
  bool _initialized = false;

  final Map<int, Circle> _circlesMaps = <int, Circle>{};

  @override
  void paint(Canvas canvas, Size size) {

    if(!_initialized){
      _viewWidth = size.width;
      _viewHeight = size.height;
      _initialized = true;
      debugPrint("Painter init $_viewWidth $_viewHeight}");
      start();
    }

    for(final Circle stain in _circlesMaps.values.toList()){
      stain.draw(canvas, _viewWidth, _viewHeight, _stainPaint);
    }

  }

  void start(){
    for(int i = 0; i <= _circlesCount; i++){
      final Circle circle = _createStain(i);
      _circlesMaps[i] = circle;
    }
  }

  Circle _createStain(int id){
    final size = max(_viewWidth, _viewHeight) / 2;
    return Circle(
      id: id,
      x: _random.nextBool() ? -size : _viewWidth + size,
      y: _random.nextBool() ? -size : _viewHeight + size,
      xVector: doubleInRange(_random, -3.3, 3.3),
      yVector: doubleInRange(_random, -3.3, 3.3),
      size: size,
      color: colors.randomItem(_random),
      stainListener: this,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  void onCircleAnimationComplete(int id) {
    _circlesMaps.remove(id);
    _circlesMaps[id] = _createStain(id);
  }

  @override
  void orientationChanged() {
    // TODO: implement orientationChanged
  }

}