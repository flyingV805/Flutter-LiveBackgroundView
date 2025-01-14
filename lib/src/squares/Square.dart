import 'dart:ui';
import 'package:animated_background_view/src/squares/SquareRotation.dart';

class Square {


  void draw(Canvas canvas, double viewWidth, double viewHeight, Paint paint){

    final square = calculateRotatedSquarePoints(
      const Offset(5, 5),
      50,
      20
    );

    // Рисуем квадрат
    final path = Path();

    path.moveTo(square[0].x, square[0].y);

    for (int i = 1; i < square.length; i++) {
      path.lineTo(square[i].x, square[i].y);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

}