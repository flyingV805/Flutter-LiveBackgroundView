import 'dart:ui';

import 'MovingGlareListener.dart';

class MovingGlare {

  final int id;
  double x;
  double y;
  final double xVector;
  final double yVector;
  final double size;
  final Color color;
  double multiplierFactor;
  final double incrementFactor;
  final MovingGlareListener glareListener;

  MovingGlare({
    required this.id,
    required this.x,
    required this.y,
    required this.xVector,
    required this.yVector,
    required this.size,
    required this.color,
    required this.multiplierFactor,
    required this.incrementFactor,
    required this.glareListener
  });

  double _alpha = 0.0;

  /*

  ..imageFilter = ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15)
  ..blendMode = BlendMode.srcOver;

  */
  //..blendMode = BlendMode.clear;

  void draw(Canvas canvas, double viewWidth, double viewHeight, Paint paint){
    if (_alpha > 1){ multiplierFactor *= -1.0; }

    _alpha += incrementFactor * multiplierFactor;
    x += xVector;
    y += yVector;

    final isOutsideView = ((x + size) < 0 || (x - size) > viewWidth) && ((y + size) < 0 || (y - size) > viewHeight);
    final isInvisible = isOutsideView || _alpha <= 0.0;

    if (isInvisible) {
      glareListener.onGlareAnimationComplete(id);
      return;
    }

    paint.color = color.withOpacity(_alpha.clamp(0, 1));

    canvas.drawCircle(Offset(x, y), size, paint);
  }

}