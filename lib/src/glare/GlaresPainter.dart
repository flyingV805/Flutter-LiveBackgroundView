import 'package:flutter/material.dart';

import 'Glare.dart';

class GlaresPainter extends CustomPainter {

  //final ValueNotifier<bool> repaint;

  GlaresPainter({super.repaint});

  double _screenWidth = 0.0;
  double _screenHeight = 0.0;
  bool _initialized = false;

  final Map<int, Glare> _glareMaps = <int, Glare>{};

  @override
  void paint(Canvas canvas, Size size) {
    if(!_initialized){
      _screenWidth = size.width;
      _screenHeight = size.height;
      _initialized = true;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }

}