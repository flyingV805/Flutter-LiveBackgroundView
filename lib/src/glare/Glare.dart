import 'dart:ui';

import 'GlareListener.dart';

class Glare {

  final int id;
  final double x;
  final double y;
  final double size;
  final GlareListener glareListener;

  Glare({
    required this.id,
    required this.x,
    required this.y,
    required this.size,
    required this.glareListener
  });

  double _alpha = 0.0;
  double _multiplierFactor = 0.0;
  double _incrementFactor = 0.0;

  final Paint _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..style = PaintingStyle.fill;

  void draw(Canvas canvas){
    if (_alpha > 1){ _multiplierFactor *= -1.0; }
    _alpha += _incrementFactor * _multiplierFactor;
    if (_alpha <= 0.0) {
      glareListener.onGlareAnimationComplete(id);
      return;
    }

    //canvas.drawCircle(Offset(x, y), _size, _paint);

  }

}