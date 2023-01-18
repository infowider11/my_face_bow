import 'dart:ui';
import 'dart:ui' as UI;

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
  }) {
    canvas.drawLine(
      Offset(
        translateX(p1.x, rotation, size, absoluteImageSize),
        translateY(p1.y, rotation, size, absoluteImageSize),
      ),
      Offset(
        translateX(p2.x, rotation, size, absoluteImageSize),
        translateY(p2.y, rotation, size, absoluteImageSize),
      ),
      paint,
    );
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
    if(opposite){
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
    double c = constant-0;

    double x = x1+0;
    if(opposite){
      x = x1-0;
    }
    double y = (m * x) + c;

    double x3 = x1 - increamentSize * 7;
    if(opposite){
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
    drawLineBetweenTwoPoints(p1: p1, p2: p2);

    return math.sqrt(((p1.y-p2.y)*(p1.y-p2.y))+((p1.x-p2.x)*(p1.x-p2.x)));


  }



}
