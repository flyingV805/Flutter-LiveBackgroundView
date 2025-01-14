import 'package:flutter/cupertino.dart';

abstract class BackgroundPainter extends CustomPainter {

  BackgroundPainter({ super.repaint });

  void orientationChanged();

}