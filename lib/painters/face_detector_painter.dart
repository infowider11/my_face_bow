import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:my_face_bow/constants/colors.dart';

import '../functions/coordinates_translator.dart';

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(this.faces, this.absoluteImageSize, this.rotation);

  final List<Face> faces;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.red;

    for (final Face face in faces) {
      // canvas.drawRect(
      //   Rect.fromLTRB(
      //     translateX(face.boundingBox.left, rotation, size, absoluteImageSize),
      //     translateY(face.boundingBox.top, rotation, size, absoluteImageSize),
      //     translateX(face.boundingBox.right, rotation, size, absoluteImageSize),
      //     translateY(
      //         face.boundingBox.bottom, rotation, size, absoluteImageSize),
      //   ),
      //   paint,
      // );

      // canvas.drawLine(fac, p2, paint)

      void paintContour(FaceContourType type) {
        final faceContour = face.contours[type];
        if (faceContour?.points != null) {
          for (final Point point in faceContour!.points) {
            // canvas.drawCircle(
            //     Offset(
            //       translateX(
            //           point.x.toDouble(), rotation, size, absoluteImageSize),
            //       translateY(
            //           point.y.toDouble(), rotation, size, absoluteImageSize),
            //     ),
            //     1,
            //     paint);
          }
          // canvas.drawLine(p1, p2, paint)
        }
      }

      // paintContour(FaceContourType.face);
      // paintContour(FaceContourType.leftEyebrowTop);
      // paintContour(FaceContourType.leftEyebrowBottom);
      // paintContour(FaceContourType.rightEyebrowTop);
      // paintContour(FaceContourType.rightEyebrowBottom);
      // paintContour(FaceContourType.leftEye);
      // paintContour(FaceContourType.rightEye);
      // paintContour(FaceContourType.upperLipTop);
      // paintContour(FaceContourType.upperLipBottom);
      // paintContour(FaceContourType.lowerLipTop);
      // paintContour(FaceContourType.lowerLipBottom);
      // paintContour(FaceContourType.noseBridge);
      // paintContour(FaceContourType.noseBottom);
      // paintContour(FaceContourType.leftCheek);
      // paintContour(FaceContourType.rightCheek);
      Map<FaceContourType, FaceContour?> faceLandmarks = face.contours;
      FaceContour? leftEye = faceLandmarks[FaceContourType.leftEye];
      FaceContour? rightEye = faceLandmarks[FaceContourType.rightEye];
      FaceContour? lowerLipTop = faceLandmarks[FaceContourType.lowerLipTop];
      FaceContour? lowerLipBottom =
          faceLandmarks[FaceContourType.lowerLipBottom];
      FaceContour? upperLipBottom =
          faceLandmarks[FaceContourType.upperLipBottom];
      FaceContour? upperLipTop = faceLandmarks[FaceContourType.upperLipTop];
      print('the ${face.landmarks}');

      // print(
      //     'drawing contour line with left point ${leftEye} and right ${rightEye}  ${(rightEye!.points.length - 1 / 2).floor()}');
      // print(
      //     'drawing contour  ${faces.length} line lip points ${upperLipBottom!.points.length}');

      /// line between the eyes  : INTER PUPILLARY LINE
      double interPupilaryLinex1 =
          leftEye!.points[leftEye!.points.length - 1].x.toDouble();
      double interPupilaryLiney1 =
          leftEye!.points[leftEye!.points.length - 1].y.toDouble();
      double interPupilaryLinex2 = rightEye!
          .points[((rightEye!.points.length - 1) / 2).ceil()].x
          .toDouble();
      double interPupilaryLiney2 = rightEye!
          .points[((rightEye!.points.length - 1) / 2).ceil()].y
          .toDouble();

       getFirstPoint({
        required double x1,
        required double y1,
        required double x2,
        required double y2,
         required double increamentSize,
      }) {

        print('all the points are(${x1}, ${y1}) and (${x2}, ${y2})');

        double m = (y2 - y1)/(x2-x1);
        double c = y1 - (m*x1);

        if(x1<x2){
          double x = x1 - increamentSize;
          double y = (m*x)+c;


          double x3 = x2 + increamentSize;
          double y3 = (m*x3)+c;
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

        }else{
          double x = x1 + increamentSize;
          double y = (m*x)+c;


          double x3 = x2 - increamentSize;
          double y3 = (m*x3)+c;
          canvas.drawLine(
            Offset(
              translateX(x, rotation, size, absoluteImageSize),
              translateY(y, rotation, size, absoluteImageSize),
            ),
            Offset(
              translateX(x3, rotation, size, absoluteImageSize),
              translateY(y3, rotation, size, absoluteImageSize),
            ),
            paint..color = MyColors.primaryColor,
          );
        }

      }

      // canvas.drawLine(
      //   Offset(
      //     translateX(interPupilaryLinex1, rotation, size, absoluteImageSize),
      //     translateY(interPupilaryLiney1, rotation, size, absoluteImageSize),
      //   ),
      //   Offset(
      //     translateX(interPupilaryLinex2, rotation, size, absoluteImageSize),
      //     translateY(interPupilaryLiney2, rotation, size, absoluteImageSize),
      //   ),
      //   paint..color = MyColors.primaryColor,
      // );

       getFirstPoint(x1: interPupilaryLinex1, y1: interPupilaryLiney1, x2: interPupilaryLinex2, y2: interPupilaryLiney2, increamentSize: 40);

      /// line of lower lips  UPPER RIM LINE
      double upperRimLinex1 = upperLipBottom!.points[0].x.toDouble();
      double upperRimLiney1 = upperLipBottom!.points[0].y.toDouble();
      double upperRimLinex2 = upperLipBottom!.points[upperLipBottom!.points.length - 1].x
          .toDouble();
      double upperRimLiney2 = upperLipBottom!.points[upperLipBottom!.points.length - 1].y
          .toDouble();


      getFirstPoint(x1: upperRimLinex1, y1: upperRimLiney1, x2: upperRimLinex2, y2: upperRimLiney2, increamentSize: 50);
      // canvas.drawLine(
      //   Offset(
      //     translateX(upperRimLinex1, rotation, size,
      //         absoluteImageSize),
      //     translateY(upperLipBottom!.points[0].y.toDouble(), rotation, size,
      //         absoluteImageSize),
      //   ),
      //   Offset(
      //     translateX(
      //         upperLipBottom!.points[upperLipBottom!.points.length - 1].x
      //             .toDouble(),
      //         rotation,
      //         size,
      //         absoluteImageSize),
      //     translateY(
      //         upperLipBottom!.points[upperLipBottom!.points.length - 1].y
      //             .toDouble(),
      //         rotation,
      //         size,
      //         absoluteImageSize),
      //   ),
      //   paint..color = MyColors.redColor,
      // );
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.faces != faces;
  }
}
