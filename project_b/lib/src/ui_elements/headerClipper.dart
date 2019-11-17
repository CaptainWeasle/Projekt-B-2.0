import 'dart:ui';

import 'package:flutter/cupertino.dart';

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 400);
    path.lineTo(800, 800);
    path.lineTo(size.width - 500, size.height - 500);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
