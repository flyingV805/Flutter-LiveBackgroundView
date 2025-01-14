import 'dart:math';
import 'dart:ui';

/// Функция для вычисления точек повернутого квадрата
List<Point<double>> calculateRotatedSquarePoints(Offset center, double sideLength, double angle) {

  final halfSide = sideLength / 2;

  // Исходные вершины без поворота
  final points = [
    Point(center.dx - halfSide, center.dy - halfSide),
    Point(center.dx + halfSide, center.dy - halfSide),
    Point(center.dx + halfSide, center.dy + halfSide),
    Point(center.dx - halfSide, center.dy + halfSide),
  ];

  // Вычисляем поворот
  final cosTheta = cos(angle);
  final sinTheta = sin(angle);

  return points.map((point) {
    final dx = point.x - center.dx;
    final dy = point.y - center.dy;
    return Point<double>(
      center.dx + dx * cosTheta - dy * sinTheta,
      center.dy + dx * sinTheta + dy * cosTheta,
    );
  }).toList();

}