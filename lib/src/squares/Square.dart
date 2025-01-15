import 'dart:ui';

import 'package:flutter/material.dart';

import 'SquareListener.dart';
import 'SquareRotator.dart';

class Square {

  final int id;
  double x;
  double y;
  final double xVector;
  final double yVector;
  final double size;
  final bool shadows;
  final Color color;
  double rotation;
  double rotationFactor;
  final SquareListener squareListener;

  Square({
    required this.id,
    required this.x,
    required this.y,
    required this.xVector,
    required this.yVector,
    required this.size,
    required this.shadows,
    required this.color,
    required this.rotation,
    required this.rotationFactor,
    required this.squareListener
  });

  void draw(Canvas canvas, double viewWidth, double viewHeight, Paint paint){

    final isInvisible =
      ((x + size) < 0 || (x - size) > viewWidth) ||
      ((y + size) < 0 || (y - size) > viewHeight);

    if (isInvisible) {
      squareListener.onSquareAnimationComplete(id);
      return;
    }

    x += xVector;
    y += yVector;
    rotation += rotationFactor;

    final square = calculateRotatedSquarePoints(
      Offset(x, y),
      size,
      rotation
    );

    paint.color = color;

    // Рисуем квадрат
    final path = Path();
    path.moveTo(square[0].x, square[0].y);
    for (int i = 1; i < square.length; i++) { path.lineTo(square[i].x, square[i].y); }
    path.close();

    if(shadows) {
      canvas.drawShadow(path, Colors.black, 16, true);
    }

    canvas.drawPath(path, paint);

  }

}