import 'dart:math';
import 'dart:ui';

import 'package:animated_background_view/src/movingGlare/MovingGlare.dart';
import 'package:animated_background_view/src/utils/list.dart';
import 'package:flutter/material.dart';

import '../utils/BackgroundPainter.dart';
import '../utils/math.dart';
import 'MovingGlareListener.dart';

class MovingGlarePainter extends BackgroundPainter implements MovingGlareListener {

  final Random _random = Random();
  final List<Color> colors;
  final int glareCount;
  final double glareSize;
  final bool enableBlur;
  final double blurAmount;

  final Paint _glarePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..style = PaintingStyle.fill;

  MovingGlarePainter({
    super.repaint,
    required this.colors,
    required this.glareCount,
    required this.glareSize,
    required this.enableBlur,
    required this.blurAmount,
  }){
   if(enableBlur){
     _glarePaint.imageFilter = ImageFilter.blur(
       sigmaX: blurAmount,
       sigmaY: blurAmount,
       tileMode: TileMode.decal
     );
   }
  }

  double _viewWidth = 0.0;
  double _viewHeight = 0.0;
  bool _initialized = false;

  final Map<int, MovingGlare> _glareMaps = <int, MovingGlare>{};

  @override
  void paint(Canvas canvas, Size size) {
    if(!_initialized){
      _viewWidth = size.width;
      _viewHeight = size.height;
      _initialized = true;
      debugPrint("Painter init $_viewWidth $_viewHeight}");
      start();
    }

    for(final MovingGlare glare in _glareMaps.values.toList()){
      glare.draw(canvas, _viewWidth, _viewHeight, _glarePaint);
    }

  }

  void start(){
    for(int i = 0; i <= glareCount; i++){
      final MovingGlare glare = _createGlare(i);
      _glareMaps[i] = glare;
    }
  }

  MovingGlare _createGlare(int id){
    return MovingGlare(
      id: id,
      x: doubleInRange(_random, 0.0, _viewWidth),
      y: doubleInRange(_random, 0.0, _viewHeight),
      xVector: doubleInRange(_random, -0.3, 0.3),
      yVector: doubleInRange(_random, -0.3, 0.3),
      size: glareSize,
      color: colors.randomItem(_random),
      multiplierFactor: doubleInRange(_random, 0.005, 0.03),
      incrementFactor: doubleInRange(_random, 0.05, 0.3),
      glareListener: this,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  void onGlareAnimationComplete(int id) {
    _glareMaps.remove(id);
    _glareMaps[id] = _createGlare(id);
  }

  @override
  void orientationChanged() {
    // TODO: implement orientationChanged
  }

}