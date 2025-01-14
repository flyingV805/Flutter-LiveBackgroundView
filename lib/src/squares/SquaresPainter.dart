
import 'dart:math';
import 'dart:ui';

import 'package:animated_background_view/src/squares/Square.dart';
import 'package:animated_background_view/src/utils/list.dart';
import 'package:flutter/material.dart';

import '../utils/BackgroundPainter.dart';
import '../utils/math.dart';
import 'SquareListener.dart';

class SquaresPainter extends BackgroundPainter implements SquareListener {

  final Random _random = Random();
  final List<Color> colors;
  final int squareCount = 6;
  final bool enableBlur;
  final double blurAmount;

  final Paint _squarePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..style = PaintingStyle.fill;

  SquaresPainter({
    super.repaint,
    required this.colors,
    required this.enableBlur,
    required this.blurAmount,
  }){
    if(enableBlur){
      _squarePaint.imageFilter = ImageFilter.blur(
        sigmaX: blurAmount,
        sigmaY: blurAmount,
        tileMode: TileMode.decal
      );
    }
  }

  double _viewWidth = 0.0;
  double _viewHeight = 0.0;
  bool _initialized = false;

  final Map<int, Square> _squareMap = <int, Square>{};


  @override
  void paint(Canvas canvas, Size size) {
    if(!_initialized){
      _viewWidth = size.width;
      _viewHeight = size.height;
      _initialized = true;
      debugPrint("Painter init $_viewWidth $_viewHeight}");
      start();
    }

    for(final Square square in _squareMap.values.toList()){
      square.draw(canvas, _viewWidth, _viewHeight, _squarePaint);
    }

  }

  void start(){
    for(int i = 0; i <= squareCount; i++){
      final Square square = _createSquare(i);
      _squareMap[i] = square;
    }
  }

  Square _createSquare(int id){
    final squareSize = max(_viewWidth, _viewHeight);
    final rotationDirection = _random.nextBool();
    final rotationFactor = rotationDirection ? doubleInRange(_random, -0.001, -0.005) : doubleInRange(_random, 0.001, 0.005);
    return Square(
      id: id,
      x: _random.nextBool() ? -squareSize : _viewWidth + squareSize,
      y: _random.nextBool() ? -squareSize : _viewHeight + squareSize,
      xVector: doubleInRange(_random, -5, 5),
      yVector: doubleInRange(_random, -5, 5),
      size: squareSize,
      color: colors.randomItem(_random),
      rotation: doubleInRange(_random, 0, 180),
      rotationFactor: rotationFactor,
      squareListener: this,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;


  @override
  void onSquareAnimationComplete(int id) {
    _squareMap.remove(id);
    _squareMap[id] = _createSquare(id);
  }

  @override
  void orientationChanged() {
    _initialized = false;
  }


}