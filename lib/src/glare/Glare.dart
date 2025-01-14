import 'dart:ui';

import 'package:flutter/material.dart';

import 'GlareListener.dart';

class Glare {

  final int id;
  final double x;
  final double y;
  final double size;
  final Color color;
  double multiplierFactor;
  final double incrementFactor;
  final GlareListener glareListener;

  Glare({
    required this.id,
    required this.x,
    required this.y,
    required this.size,
    required this.color,
    required this.multiplierFactor,
    required this.incrementFactor,
    required this.glareListener
  });

  double _alpha = 0.0;

  void draw(Canvas canvas, Paint paint){
    if (_alpha > 1){ multiplierFactor *= -1.0; }
    _alpha += incrementFactor * multiplierFactor;
    if (_alpha <= 0.0) {
      glareListener.onGlareAnimationComplete(id);
      return;
    }

    paint.color = color.withOpacity(_alpha.clamp(0, 1));
    canvas.drawCircle(Offset(x, y), size, paint);
  }

}