import 'package:flutter/material.dart';

class ClipperLeft extends CustomClipper<Path>{
  @override
  getClip(Size size) {
    var path = Path();
    var fillet = 35.0;

    path.moveTo(0, size.height * 0.15 + 10);
    //path.quadraticBezierTo(0, size.height * 0.15, 50, size.height * 0.15 + 30);

    path.lineTo(0, size.height - fillet);
    path.quadraticBezierTo(0, size.height, fillet, size.height);

    path.lineTo(size.width - fillet, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - fillet);

    path.lineTo(size.width, 20);
    path.quadraticBezierTo(size.width, 0, size.width - 20, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class ClipperRight extends CustomClipper<Path>{
  @override
  getClip(Size size) {
    var path = Path();
    var fillet = 35.0;

    path.lineTo(0, size.height - fillet);
    path.quadraticBezierTo(0, size.height, fillet, size.height);

    path.lineTo(size.width - fillet, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - fillet);

    path.lineTo(size.width, size.height *0.15 + 10);

    path.lineTo(20, 0);
    path.quadraticBezierTo(0, 0, 0, 20);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class ClipperTop extends CustomClipper<Path>{
  @override
  getClip(Size size) {
    var path = Path();
    var fillet = 20.0;

    path.lineTo(0, size.height - (size.height *0.15 + 10) - fillet );
    path.quadraticBezierTo(0, size.height - (size.height *0.15 + 10), fillet, size.height - (size.height *0.15 + 10) + 5);
    path.lineTo(size.width/2, size.height);

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - (size.height *0.15 + 10) - fillet );
    path.quadraticBezierTo(size.width, size.height - (size.height *0.15 + 10), size.width - fillet, size.height - (size.height *0.15 + 10) + 5);
    //path.lineTo(size.width/2, size.height);
    path.lineTo(size.width/2, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}