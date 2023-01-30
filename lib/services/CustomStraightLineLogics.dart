import 'dart:ui';
import 'dart:ui' as UI;

import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../constants/colors.dart';
import '../functions/coordinates_translator.dart';
import 'dart:math' as math;

class StraightLineModal {
  double tangent;
  double constant;

  StraightLineModal({
    required this.tangent,
    required this.constant,
  });
}

class CustomPoint {
  double x;
  double y;

  CustomPoint({
    required this.x,
    required this.y,
  });
}

class CustomStraightLineLogics {
  Canvas canvas;
  Size size;

  final Size absoluteImageSize;
  final InputImageRotation rotation;
  final UI.Image? image;
  final Paint paint;

  CustomStraightLineLogics(
      {required this.canvas,
      required this.size,
      required this.absoluteImageSize,
      required this.rotation,
      required this.paint,
      required this.image});

  static StraightLineModal getTangentAndConstantBetweenTwoPoints(
    CustomPoint p1,
    CustomPoint p2,
  ) {
    print('all the points are(${p1.x}, ${p1.y}) and (${p2.x}, ${p2.y})');

    double m = (p2.y - p1.y) / (p2.x - p1.x);
    double c = p1.y - (m * p1.x);
    return StraightLineModal(tangent: m, constant: c);
  }

  drawLineBetweenTwoPoints({
    required CustomPoint p1,
    required CustomPoint p2,
    double extendSizeLeft = 0,
    double extendSizeRight = 0,
    Paint? cPaint,
    bool isArrow = false,
  }) {
    double x1 = p1.x;
    double y1 = p1.y;
    double x2 = p2.x;
    double y2 = p2.y;
    if (extendSizeLeft != 0) {
      // y = mx+c
      var a = getTangentAndConstantBetweenTwoPoints(p1, p2);
      double m = a.tangent;
      double c = a.constant;

      x1 = p1.x + extendSizeLeft;
      y1 = (m * x1) + c;
    }
    if (extendSizeRight != 0) {
      // y = mx+c
      var a = getTangentAndConstantBetweenTwoPoints(p1, p2);
      double m = a.tangent;
      double c = a.constant;

      x2 = p2.x + extendSizeRight;
      y2 = (m * x2) + c;
    }

    canvas.drawLine(
      Offset(
        translateX(x1, rotation, size, absoluteImageSize),
        translateY(y1, rotation, size, absoluteImageSize),
      ),
      Offset(
        translateX(x2, rotation, size, absoluteImageSize),
        translateY(y2, rotation, size, absoluteImageSize),
      ),
      cPaint ?? paint,
    );
    // if (isArrow) {
    //   drawTraingleFromPointAndTangent(CustomPoint(x: x2, y: y2),
    //       getTangentAndConstantBetweenTwoPoints(p1, p2), cPaint: paint..style=PaintingStyle.fill..strokeWidth=1);
    // }

  }

  drawTraingleFromPointAndTangent(
      CustomPoint point, StraightLineModal tangentAndConstant,
      {Paint? cPaint}) {
    print('I am Called');

    final arrowSize = 8;
    final arrowAngle = 20 * math.pi / 180;

    double trainglePoint1x = point.x - arrowSize;

    double radian = 35 * 0.0174533;

    double m2 = (math.tan(radian) + tangentAndConstant.tangent) /
        (1 - (math.tan(radian) * tangentAndConstant.tangent));
    // (x+m1/a-xm1) = m2 where x is the tan theta
    print(
        'the slope of a line is ${m2}  ${math.atan(m2) * 57.2958} and m1 is ${tangentAndConstant.tangent} , ${math.atan(tangentAndConstant.tangent) * 57.2958}');
    print(
        'the tan 120 and 45 is ${math.tan(radian)} and ${math.tan(45 * 0.0174533)} and ${math.atan(1) * 57.2958} and ${math.tan(45)}');
    double c2 = (point.x * (tangentAndConstant.tangent - m2)) +
        tangentAndConstant.constant;
    //c2 = (m1-m2)x1+c1
    print(
        'the constant is ${c2} and old constant is ${tangentAndConstant.constant}');
    double trainglePoint1y = m2 * trainglePoint1x + c2;
    print('the point is (${trainglePoint1x}, $trainglePoint1y)');
    drawLineBetweenTwoPoints(
        p1: point,
        p2: CustomPoint(x: trainglePoint1x, y: trainglePoint1y),
        cPaint: (cPaint ?? paint));

    double trainglePoint1x2 = point.x - 22;

    double radian2 = 145 * 0.0174533;

    double m22 = (math.tan(radian2) + tangentAndConstant.tangent) /
        (1 - (math.tan(radian2) * tangentAndConstant.tangent));
    // (x+m1/a-xm1) = m22 where x is the tan theta
    print(
        'the slope of a line is ${m22}  ${math.atan(m22) * 57.2958} and m1 is ${tangentAndConstant.tangent} , ${math.atan(tangentAndConstant.tangent) * 57.2958}');
    print(
        'the tan 120 and 45 is ${math.tan(radian2)} and ${math.tan(45 * 0.0174533)} and ${math.atan(1) * 57.2958} and ${math.tan(45)}');
    double c22 = (point.x * (tangentAndConstant.tangent - m22)) +
        tangentAndConstant.constant;
    //c2 = (m1-m2)x1+c1
    print(
        'the constant is ${c22} and old constant is ${tangentAndConstant.constant}');
    double trainglePoint1y2 = m22 * trainglePoint1x2 + c22;
    print('the point is (${trainglePoint1x2}, $trainglePoint1y2)');
    drawLineBetweenTwoPoints(
        p1: point,
        p2: CustomPoint(x: trainglePoint1x2, y: trainglePoint1y2),
        cPaint: (cPaint ?? paint));

    drawLineBetweenTwoPoints(
        p1: CustomPoint(x: trainglePoint1x, y: trainglePoint1y),
        p2: CustomPoint(x: trainglePoint1x2, y: trainglePoint1y2),
        cPaint: (cPaint ?? paint));


    // canvas.drawPath(Pat paint)

    // canvas.drawPoints(
    //   PointMode.polygon,
    //   [
    //    getOffset(CustomPoint(x: trainglePoint1x, y: trainglePoint1y)),
    //    getOffset(CustomPoint(x: trainglePoint1x2, y: trainglePoint1y2)),
    //    getOffset(point),
    //     getOffset(CustomPoint(x: trainglePoint1x, y: trainglePoint1y)),
    //   ],
    //   paint..color=Colors.orange..style=PaintingStyle.fill
    //   // cPaint ?? paint,
    // );

    // final dX = p2.x - p1.x;
    // final dY = p2.y - p1.y;
    // final angle = math.atan2(dY, dX);
    // final path = Path();
    //
    // path.moveTo(p2.x - arrowSize * math.cos(angle - arrowAngle),
    //     p2.y - arrowSize * math.sin(angle - arrowAngle));
    // path.lineTo(p2.x, p2.y);
    // path.lineTo(p2.x - arrowSize * math.cos(angle + arrowAngle),
    //     p2.y - arrowSize * math.sin(angle + arrowAngle));
    // path.close();
    // canvas.drawPath(path, cPaint??paint);
  }

  Offset getOffset(CustomPoint p) {
    print('the points in offset are ${p.x}, ${p.y}');
    return Offset(p.x, p.y);
  }

  drawStraightLine({
    required double x1,
    required double y1,
    required double x2,
    required double y2,
    required double increamentSize,
  }) {
    print('all the points are(${x1}, ${y1}) and (${x2}, ${y2})');

    double m = (y2 - y1) / (x2 - x1);
    double c = y1 - (m * x1);

    if (x1 < x2) {
      double x = x1 - increamentSize;
      double y = (m * x) + c;

      double x3 = x2 + increamentSize;
      double y3 = (m * x3) + c;
      canvas.drawLine(
        Offset(
          translateX(x, rotation, size, absoluteImageSize),
          translateY(y, rotation, size, absoluteImageSize),
        ),
        Offset(
          translateX(x3, rotation, size, absoluteImageSize),
          translateY(y3, rotation, size, absoluteImageSize),
        ),
        paint,
      );
    } else {
      double x = x1 + increamentSize;
      double y = (m * x) + c;

      double x3 = x2 - increamentSize;
      double y3 = (m * x3) + c;
      canvas.drawLine(
        Offset(
          translateX(x, rotation, size, absoluteImageSize),
          translateY(y, rotation, size, absoluteImageSize),
        ),
        Offset(
          translateX(x3, rotation, size, absoluteImageSize),
          translateY(y3, rotation, size, absoluteImageSize),
        ),
        paint..color = MyColors.lightBlueColor,
      );
    }
  }

  drawSideFaceLine({
    required double x1,
    required double y1,
    required double x2,
    required double y2,
    required double increamentSize,
    required bool opposite,
    double constantDeviation = 0,
  }) {
    print('all the points are side (${x1}, ${y1}) and (${x2}, ${y2})');

    double m = (y2 - y1) / (x2 - x1);
    double c = y1 - (m * x1) + constantDeviation;

    print('The m is $m and c is $c and increment is $increamentSize');

    // double x = x1 - increamentSize;
    // if(opposite){
    //   x = x1 + increamentSize;
    // }
    double y = (m * x1) + c;

    double x3 = x2 - increamentSize * 5;
    if (opposite) {
      x3 = x2 - increamentSize * 5;
    }
    double y3 = (m * x3) + c;
    print('all the points are drawing if (${x1}, ${y}) and (${x3}, ${y3})');

    canvas.drawLine(
      Offset(
        translateX(x1, rotation, size, absoluteImageSize),
        translateY(y, rotation, size, absoluteImageSize),
      ),
      Offset(
        translateX(x3, rotation, size, absoluteImageSize),
        translateY(y3, rotation, size, absoluteImageSize),
      ),
      paint,
    );
  }

  drawSideFaceLineWithTangentAndConstant({
    required double x1,
    required double y1,
    required double tangent,
    required double constant,
    required double increamentSize,
    required bool opposite,
  }) {
    print(
        'all the points are drawSideFaceLineWithTangentAndConstant(${x1}, ${y1}) and (${tangent},and  ${constant})');

    double m = tangent;
    double c = constant - 0;

    double x = x1 + 0;
    if (opposite) {
      x = x1 - 0;
    }
    double y = (m * x) + c;

    double x3 = x1 - increamentSize * 7;
    if (opposite) {
      x3 = x1 + increamentSize * 7;
    }
    double y3 = (m * x3) + c;

    print('drawing line on ($x,$y) and ($x3,$y3)');
    canvas.drawLine(
      Offset(
        translateX(x, rotation, size, absoluteImageSize),
        translateY(y, rotation, size, absoluteImageSize),
      ),
      Offset(
        translateX(x3, rotation, size, absoluteImageSize),
        translateY(y3, rotation, size, absoluteImageSize),
      ),
      paint..color = MyColors.lightBlueColor,
    );
  }

  double measureDistanceBetweenTwoPoints({
    required CustomPoint p1,
    required CustomPoint p2,
    double extendSizeLeft = 0,
    double extendSizeRight = 0,
  }) {
    drawLineBetweenTwoPoints(
        p1: p1,
        p2: p2,
        extendSizeRight: extendSizeRight,
        extendSizeLeft: extendSizeLeft);

    return math.sqrt(
            ((p1.y - p2.y) * (p1.y - p2.y)) + ((p1.x - p2.x) * (p1.x - p2.x))) *
        0.2645833333;
  }

  CustomPoint getCenterPointBetweenTwoPoints({
    required CustomPoint p1,
    required CustomPoint p2,
  }) {
    return CustomPoint(x: (p1.x + p2.x) / 2, y: (p1.y + p2.y) / 2);
  }
}
