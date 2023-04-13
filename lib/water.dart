import 'dart:math';

import 'package:flutter/material.dart';

class Water extends CustomPainter {
  double HEIGHT_FACTOR = 1;
  static const double ANIMATION_SCALE = 0.0008;

  @override
  Water(double height_factor) : super(){
    HEIGHT_FACTOR = height_factor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final path = Path();
    // paint.style = PaintingStyle.stroke;
    // paint.strokeWidth = 15;
    paint.color = const Color(0xFFB4FAF4);
    path.moveTo(0, size.height * 0.9 * HEIGHT_FACTOR);
    path.quadraticBezierTo(
      size.width * 0.1,
      size.height * 0.9 * (HEIGHT_FACTOR + getRandomHeight(ANIMATION_SCALE)),
      size.width * 0.3,
      size.height * 0.92 * (HEIGHT_FACTOR + getRandomHeight(ANIMATION_SCALE)),
    );
    path.quadraticBezierTo(
      size.width * 0.45,
      size.height * 0.939 * (HEIGHT_FACTOR + getRandomHeight(ANIMATION_SCALE)),
      size.width * 0.6,
      size.height * 0.92 * (HEIGHT_FACTOR + getRandomHeight(ANIMATION_SCALE)),
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.91 * (HEIGHT_FACTOR + getRandomHeight(ANIMATION_SCALE)),
      size.width * 0.85,
      size.height * 0.912 * (HEIGHT_FACTOR + getRandomHeight(ANIMATION_SCALE)),
    );
    path.quadraticBezierTo(
      size.width * 0.95,
      size.height * 0.92 * (HEIGHT_FACTOR + getRandomHeight(ANIMATION_SCALE)),
      size.width * 1,
      size.height * 0.93 * (HEIGHT_FACTOR + getRandomHeight(ANIMATION_SCALE)),
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.8);
    canvas.drawPath(path, paint);
    final paint1 = Paint();
    paint1.style = PaintingStyle.fill;
    paint1.color = const Color(0xFFB4FAF4);
    canvas.drawPath(path, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  double getRandomHeight(double scale){
    return Random().nextDouble() * 0.0008 * (Random().nextBool() ? 1 : -1);
  }
}
