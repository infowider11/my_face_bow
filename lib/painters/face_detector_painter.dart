import 'dart:math';
import 'dart:ui' as UI;

import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:my_face_bow/constants/colors.dart';
import 'package:flutter/painting.dart' as paintingFile;
import 'package:my_face_bow/constants/global_data.dart';
import 'package:my_face_bow/constants/global_keys.dart';
import 'package:my_face_bow/modals/scenario_types.dart';
import 'package:my_face_bow/providers/global_provider.dart';
import 'package:my_face_bow/widgets/showSnackbar.dart';
import 'package:provider/provider.dart';
import '../functions/coordinates_translator.dart';
import '../services/CustomStraightLineLogics.dart';
// int errorCount = 0;

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(
    this.faces,
    this.absoluteImageSize,
    this.rotation, {
    this.image,
  });

  final List<Face> faces;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  final UI.Image? image;

  @override
  void paint(Canvas canvas, Size size) {
    print('the paint size is $size');

    List<ScenarioType> selectedScenarios = [];
    Provider.of<GlobalProvider>(MyGlobalKeys.navigatorKey.currentContext!,
            listen: false)
        .selectedScenarios
        .forEach((element) {
      selectedScenarios.add(element.scenarioType);
    });

    if (selectedScenarios.length != 0) {
      print('the selected scenarios are ${selectedScenarios[0].name}');
    }
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = Colors.red;
    void _paintBackgroundImage(Canvas canvas) {
      if (image != null) {
        print('all the points are faceeeee');
        final UI.Rect rect = UI.Offset.zero & size;
        final Size imageSize =
            Size(image!.width.toDouble(), image!.height.toDouble());
        FittedSizes sizes = applyBoxFit(BoxFit.contain, imageSize, size);
        final Rect inputSubRect =
            Alignment.center.inscribe(sizes.source, Offset.zero & imageSize);
        final Rect outputSubRect =
            Alignment.center.inscribe(sizes.destination, rect);

        canvas.drawImageRect(image!, inputSubRect, outputSubRect, Paint());
      }
    }

    _paintBackgroundImage(canvas);
    for (final Face face in faces) {
      try {
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

        Map<FaceContourType, FaceContour?> faceContoursMap = face.contours;
        Map<FaceLandmarkType, FaceLandmark?> faceLandmarkMap = face.landmarks;
        FaceContour? leftEye = faceContoursMap[FaceContourType.leftEye];
        FaceContour? rightEye = faceContoursMap[FaceContourType.rightEye];
        FaceContour? lowerLipTop = faceContoursMap[FaceContourType.lowerLipTop];
        FaceContour? lowerLipBottom =
            faceContoursMap[FaceContourType.lowerLipBottom];
        FaceContour? nose = faceContoursMap[FaceContourType.noseBottom];
        FaceContour? upperLipBottom =
            faceContoursMap[FaceContourType.upperLipBottom];
        FaceContour? upperLipTop = faceContoursMap[FaceContourType.upperLipTop];
        print('the ${face.landmarks}');

        FaceLandmark? leftEar = faceLandmarkMap[FaceLandmarkType.leftEar];
        FaceLandmark? rightEar = faceLandmarkMap[FaceLandmarkType.rightEar];

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

        drawSideFaceLineWithTangentAndConstant({
          required double x1,
          required double y1,
          required double tangent,
          required double constant,
          required double increamentSize,
        }) {
          print(
              'all the points are drawSideFaceLineWithTangentAndConstant(${x1}, ${y1}) and (${tangent},and  ${constant})');

          double m = tangent;
          double c = constant-4;

          double x = x1+12;
          double y = (m * x) + c;

          double x3 = x1 - increamentSize * 7;
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
            paint..color = MyColors.redColor,
          );
        }

        drawSideFaceLine({
          required double x1,
          required double y1,
          required double x2,
          required double y2,
          required double increamentSize,
          double constantDeviation = 0,
        }) {
          print('all the points are side (${x1}, ${y1}) and (${x2}, ${y2})');

          double m = (y2 - y1) / (x2 - x1);
          double c = y1 - (m * x1) + constantDeviation;


          print('The m is $m and c is $c and increment is $increamentSize');

          if (x1 < x2) {
            double x = x1 - increamentSize;
            double y = (m * x) + c;

            double x3 = x2 - increamentSize * 5;
            double y3 = (m * x3) + c;
            print('all the points are drawing if (${x}, ${y}) and (${x3}, ${y3})');

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
            double x = x1 - increamentSize/2;
            double y = (m * x) + c;

            double x3 = x2 - increamentSize * 4;
            double y3 = (m * x3) + c;
            print('all the points are drawing else (${x}, ${y}) and (${x3}, ${y3})');

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

        print('about to draw scenario $selectedScenarios');
        if (selectedScenarios
            .contains(ScenarioType.UPPEROCCULSIONFRONTALORIENTATION)) {
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

          drawStraightLine(
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

          drawStraightLine(
              x1: upperRimLinex1,
              y1: upperRimLiney1,
              x2: upperRimLinex2,
              y2: upperRimLiney2,
              increamentSize: 90);
          if (face.headEulerAngleZ != null) {
            if (face.headEulerAngleZ! > 15 ||
                face.headEulerAngleZ! < (-15) ||
                face.headEulerAngleX! > 15 ||
                face.headEulerAngleX! < (-15) ||
                face.headEulerAngleY! > 15 ||
                face.headEulerAngleY! < (-15)) {
              print(
                  'zsssssss ${MyGlobalKeys.detectedImageViewStateKey.currentState}');
              // MyGlobalKeys.homePageStateKey.currentState?.showErrorMessage();
            }
          }
        }

        if (selectedScenarios
            .contains(ScenarioType.UPPEROCCULSIONLATERALORIENTATION)) {
          print('about to draw scenario 2 UPPEROCCULSIONLATERALORIENTATION');

          /// line FROM LOWER BOTTOM LIPS TO EARS
          // double lowerLipBottomLinex1 = lowerLipBottom!.points[2].x.toDouble();
          // double lowerLipBottomLiney1 = lowerLipBottom!.points[2].y.toDouble();
          // double lowerLipBottomLinex2 =double.parse('${leftEar?.position.x??rightEar?.position.x??1}');
          // double lowerLipBottomLiney2 =double.parse('${leftEar?.position.y??rightEar?.position.y??1}');
          //
          //
          // // drawSideFaceLine(
          // //     x1: lowerLipBottomLinex1,
          // //     y1: lowerLipBottomLiney1,
          // //     x2: lowerLipBottomLinex2,
          // //     y2: lowerLipBottomLiney2,
          // //     increamentSize: 60);

          double upperRimLinex1 = lowerLipBottom!.points[1].x.toDouble();
          double upperRimLiney1 = lowerLipBottom!.points[1].y.toDouble();
          double upperRimLinex2 =
              lowerLipTop!.points[lowerLipTop!.points.length - 2].x.toDouble();
          double upperRimLiney2 =
              lowerLipTop!.points[lowerLipTop!.points.length - 2].y.toDouble();
          
          //
          // drawSideFaceLine(
          //     x1: upperRimLinex1,
          //     y1: upperRimLiney1,
          //     x2: upperRimLinex2,
          //     y2: upperRimLiney2,
          //     increamentSize: 40);

          double nosex1 = nose!.points[nose!.points.length-1].x.toDouble();
          double nosey1 = nose!.points[nose!.points.length-1].y.toDouble();

          print('the nose points are (${nosex1}, ${nosey1})');
//           var tangentAndConstant =
//               CustomStraightLineLogics.getTangentAndConstantBetweenTwoPoints(
//                   CustomPoint(x: upperRimLinex1, y: upperRimLiney1),
//                   CustomPoint(x: upperRimLinex2, y: upperRimLiney2));
// // y = mx + c;
//           double c = nosey1 - (nosex1 * tangentAndConstant.tangent);

          print('the ear points are (${leftEar!.position.x}, ${leftEar!.position.y})');
          double earx1 = double.parse('${leftEar!.position.x}');
          double eary1 = double.parse('${leftEar!.position.y}');

          drawSideFaceLine(
              x2: nosex1,
              y2: nosey1,
              x1: earx1,
              y1: eary1,
              constantDeviation: -0,
              increamentSize: 0);

          double lipCenterx1 = lowerLipTop!.points[(lowerLipTop!.points.length/2).ceil()].x.toDouble();
          double lipCentery1 = lowerLipTop!.points[(lowerLipTop!.points.length/2).ceil()].y.toDouble();

                    var tangentAndConstant =
              CustomStraightLineLogics.getTangentAndConstantBetweenTwoPoints(
                  CustomPoint(x: nosex1, y: nosey1),
                  CustomPoint(x: earx1, y: eary1));
// y = mx + c;
          double c = lipCentery1 - (lipCenterx1 * tangentAndConstant.tangent);
          

          drawSideFaceLineWithTangentAndConstant(
              x1: lipCenterx1,
              y1: lipCentery1,
              constant: c,
              increamentSize: 27,
              tangent: tangentAndConstant.tangent);
          if (face.headEulerAngleZ != null) {
            if (face.headEulerAngleZ! > 15 ||
                face.headEulerAngleZ! < (-15) ||
                face.headEulerAngleX! > 15 ||
                face.headEulerAngleX! < (-15) ||
                face.headEulerAngleY! > 15 ||
                face.headEulerAngleY! < (-15)) {
              print(
                  'zsssssss ${MyGlobalKeys.detectedImageViewStateKey.currentState}');
              // MyGlobalKeys.homePageStateKey.currentState?.showErrorMessage();
            }
          }
        }

        print(
            'the other para are euler angle x${face.headEulerAngleX} .... y ${face.headEulerAngleY}.... z ${face.headEulerAngleZ}');

        // the other para are euler angle x5.755882263183594 .... y 4.462555408477783.... z 19.31239891052246

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
      } catch (e) {
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
