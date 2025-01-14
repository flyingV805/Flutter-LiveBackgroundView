import 'dart:ui';
import 'package:animated_background_view/src/circles/CircleListener.dart';

class Circle {

  final int id;
  double x;
  double y;
  final double xVector;
  final double yVector;
  final double size;
  final Color color;
  final CircleListener stainListener;

  Circle({
    required this.id,
    required this.x,
    required this.y,
    required this.xVector,
    required this.yVector,
    required this.size,
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
    canvas.drawCircle(Offset(x, y), size, paint);

  }

}