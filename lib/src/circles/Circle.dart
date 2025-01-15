import 'dart:ui';
import 'package:animated_background_view/src/circles/CircleListener.dart';
import 'package:flutter/material.dart';

class Circle {

  final int id;
  double x;
  double y;
  final double xVector;
  final double yVector;
  final double size;
  final bool shadows;
  final Color color;
  final CircleListener stainListener;

  Circle({
    required this.id,
    required this.x,
    required this.y,
    required this.xVector,
    required this.yVector,
    required this.size,
    required this.shadows,
    required this.color,
    required this.stainListener
  });

  void draw(Canvas canvas, double viewWidth, double viewHeight, Paint paint){

    x += xVector;
    y += yVector;

    final isInvisible =
      ((x + size) < 0 || (x - size) > viewWidth) ||
      ((y + size) < 0 || (y - size) > viewHeight);

    if (isInvisible) {
      stainListener.onCircleAnimationComplete(id);
      return;
    }

    paint.color = color;

    final center = Offset(x, y);

    if(shadows){
      final shadowPath = Path()..addOval(Rect.fromCircle(center: center, radius: size));
      canvas.drawShadow(shadowPath, Colors.black, 16, true);
    }

    canvas.drawCircle(center, size, paint);

  }

}