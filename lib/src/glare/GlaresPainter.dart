import 'dart:math';

import 'package:animated_background_view/src/glare/GlareListener.dart';
import 'package:animated_background_view/src/utils/list.dart';
import 'package:flutter/material.dart';

import '../utils/math.dart';
import 'Glare.dart';

class GlaresPainter extends CustomPainter implements GlareListener {

  final Random _random = Random();
  final List<Color> colors;
  final int glareCount;
  final double glareSize;

  GlaresPainter({
    super.repaint,
    required this.colors,
    required this.glareCount,
    required this.glareSize,
  });

  double _viewWidth = 0.0;
  double _viewHeight = 0.0;
  bool _initialized = false;

  final Map<int, Glare> _glareMaps = <int, Glare>{};

  @override
  void paint(Canvas canvas, Size size) {
    if(!_initialized){
      _viewWidth = size.width;
      _viewHeight = size.height;
      _initialized = true;
      debugPrint("Painter init $_viewWidth $_viewHeight}");
      start();
    }

    for(final Glare glare in _glareMaps.values.toList()){
      glare.draw(canvas);
    }

  }

  void start(){
    for(int i = 0; i <= glareCount; i++){
      final Glare glare = _createGlare(i);
      _glareMaps[i] = glare;
    }

  }

  Glare _createGlare(int id){
    return Glare(
      id: id,
      x: doubleInRange(_random, 0.0, _viewWidth),
      y: doubleInRange(_random, 0.0, _viewHeight),
      size: glareSize,
      color: colors.randomItem(_random),
      multiplierFactor: doubleInRange(_random, 0.005, 0.03),
      incrementFactor: doubleInRange(_random, 0.05, 0.3),
      glareListener: this,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  void onGlareAnimationComplete(int id) {
    _glareMaps.remove(id);
    _glareMaps[id] = _createGlare(id);
  }

}