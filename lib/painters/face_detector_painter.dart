import 'dart:math';
import 'dart:ui' as UI;

import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:my_face_bow/constants/colors.dart';
import 'package:flutter/painting.dart' as paintingFile;
import 'package:my_face_bow/constants/global_data.dart';
import '../functions/coordinates_translator.dart';

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(
    this.faces,
    this.absoluteImageSize,
    this.rotation,
    this.image,
  );

  final List<Face> faces;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  final UI.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    print('the paint size is $size');
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.red;
    void _paintBackgroundImage(Canvas canvas) {
      if (image == null) {
        return;
      }
      final UI.Rect rect = UI.Offset.zero & size;
      final Size imageSize =
      Size(image.width.toDouble(), image.height.toDouble());
      FittedSizes sizes = applyBoxFit(BoxFit.contain, imageSize, size);
      final Rect inputSubRect =
      Alignment.center.inscribe(sizes.source, Offset.zero & imageSize);
      final Rect outputSubRect =
      Alignment.center.inscribe(sizes.destination, rect);

      canvas.drawImageRect(image, inputSubRect, outputSubRect, Paint());

    }

    _paintBackgroundImage(canvas);
    for (final Face face in faces) {
      try{
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

        paintContour(FaceContourType.face);
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
        Map<FaceContourType, FaceContour?> faceContoursMap = face.contours;
        Map<FaceLandmarkType, FaceLandmark?> faceLandmarkMap = face.landmarks;
        FaceContour? leftEye = faceContoursMap[FaceContourType.leftEye];
        FaceContour? rightEye = faceContoursMap[FaceContourType.rightEye];
        FaceContour? lowerLipTop = faceContoursMap[FaceContourType.lowerLipTop];
        FaceContour? lowerLipBottom =
        faceContoursMap[FaceContourType.lowerLipBottom];
        FaceContour? upperLipBottom =
        faceContoursMap[FaceContourType.upperLipBottom];
        FaceContour? upperLipTop = faceContoursMap[FaceContourType.upperLipTop];
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

        getFirstPoint(
            x1: interPupilaryLinex1,
            y1: interPupilaryLiney1,
            x2: interPupilaryLinex2,
            y2: interPupilaryLiney2,
            increamentSize: 40);

        /// line of lower lips  UPPER RIM LINE
        double upperRimLinex1 = upperLipBottom!.points[2].x.toDouble();
        double upperRimLiney1 = upperLipBottom!.points[2].y.toDouble();
        double upperRimLinex2 = upperLipBottom!
            .points[upperLipBottom!.points.length - 3].x
            .toDouble();
        double upperRimLiney2 = upperLipBottom!
            .points[upperLipBottom!.points.length - 3].y
            .toDouble();

        getFirstPoint(
            x1: upperRimLinex1,
            y1: upperRimLiney1,
            x2: upperRimLinex2,
            y2: upperRimLiney2,
            increamentSize: 80);




        // FaceLandmark? leftEar = faceLandmarkMap[FaceLandmarkType.leftEar];
        // FaceLandmark? rightEar = faceLandmarkMap[FaceLandmarkType.rightEar];
        //
        // print('the ear is ${leftEar}  ffff ${leftEar?.position.x} ');
        // if(leftEar!=null && rightEar!=null){
        //   double tempx1 = leftEar!.position.x + 0.0;
        //   double tempy1 = leftEar!.position.y + 0.0;
        //   double tempx2 = rightEar!.position.x + 0.0;
        //   double tempy2 =rightEar!.position.y + 0.0;
        //   getFirstPoint(
        //       x1: tempx1,
        //       y1: tempy1,
        //       x2: tempx2,
        //       y2: tempy2,
        //       increamentSize: 50);
        // }
      }catch(e){
        print('the face could not be painted ${face}. Error:  $e');
      }
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.faces != faces;
  }
}
