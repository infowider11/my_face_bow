import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    final painting = Paint()..strokeWidth = 10..color= Colors.blue..style=PaintingStyle.fill;
    print('painting line with ${painting.color}');
    canvas.drawLine(
      Offset(30,150),
      Offset(270, 150),
      painting,
    );
    Rect rect = Rect.fromCenter(center: Offset(150,150), width: 150, height: 150);
    canvas.drawArc(rect, 10, 20, true, painting..color=Colors.yellow);
    Rect lEyes = Rect.fromCenter(center: Offset(120,130), width: 20, height: 20);
    Rect rEyes = Rect.fromCenter(center: Offset(180,130), width: 20, height: 20);
    Rect smile = Rect.fromCenter(center: Offset(150,180), width: 50, height: 40);
    canvas.drawArc(lEyes, 10, 20, true, painting..color=Colors.black);
    canvas.drawArc(rEyes, 10, 20, true, painting..color=Colors.black);

    canvas.drawLine(
      Offset(150,150),
      Offset(150,160),
      painting..strokeWidth=5,
    );
    // canvas.drawArc(smile, 120, 60, true, painting..color=Colors.brown);
    Path path = Path();
    path.moveTo(120, 190);
    path.arcToPoint(Offset(180, 185), radius: Radius.circular(130), rotation: 80);
    // canvas.drawPoints(pointMode, points, paint);
    canvas.drawPath(path, painting..color=Colors.black..style=PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
