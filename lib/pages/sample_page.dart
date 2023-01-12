// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:my_face_bow/constants/global_keys.dart';
// import 'package:my_face_bow/pages/sample_camera_view.dart';
//
// import '../constants/global_functions.dart';
// import '../painters/face_detector_painter.dart';
//
// import 'dart:ui' as ui;
//
// class FaceDetectorView extends StatefulWidget {
//
//
//   @override
//   State<FaceDetectorView> createState() => _FaceDetectorViewState();
//
//   const FaceDetectorView({Key? key}): super(key: key);
// }
//
// class _FaceDetectorViewState extends State<FaceDetectorView> {
//   List savedFaces = [];
//   final FaceDetector _faceDetector = FaceDetector(
//     options: FaceDetectorOptions(
//       enableContours: true,
//       enableClassification: true,
//     ),
//   );
//   bool _canProcess = true;
//   bool _isBusy = false;
//   CustomPaint? _customPaint;
//   String? _text;
//
//   @override
//   void dispose() {
//     _canProcess = false;
//     _faceDetector.close();
//
//     // List<Face> a = [];
//     // Map<FaceLandmarkType, FaceLandmark?> landmarkes = a[0].landmarks;
//     // var abc = landmarkes[FaceLandmarkType.noseBase];
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  CameraView(
//       // title: 'Face Detector',
//       key: MyGlobalKeys.cameraViewPageStateKey,
//       customPaint: _customPaint,
//       text: _text,
//       onImage: (inputImage) {
//         processImage(inputImage);
//       },
//       initialDirection: CameraLensDirection.front,
//       onScreenModeChanged: (screenMode){
//
//       },
//     );
//   }
//
//   Future<void> processImage(InputImage inputImage) async {
//     if (!_canProcess) return;
//     if (_isBusy) return;
//     _isBusy = true;
//     setState(() {
//       _text = '';
//     });
//     List<Face> faces = await _faceDetector.processImage(inputImage);
//     print('the faces are sample page ${faces}');
//     savedFaces += faces;
//     if (inputImage.inputImageData?.size != null &&
//         inputImage.inputImageData?.imageRotation != null) {
//       // ui.Image imageFormatFile = await loadUiImage(inputImage.bytes!);
//       final painter = FaceDetectorPainter(
//           faces,
//           inputImage.inputImageData!.size,
//           inputImage.inputImageData!.imageRotation,
//           // imageFormatFile
//       );
//       print('the painter is about to paint with ${inputImage.inputImageData?.size} anddd ${inputImage.inputImageData?.imageRotation}');
//       _customPaint = CustomPaint(painter: painter);
//       setState(() {
//
//       });
//     } else {
//       String text = 'Faces found: ${faces.length}\n\n';
//       for (final face in faces) {
//         text += 'face: ${face.boundingBox}\n\n';
//       }
//       _text = text;
//       // TODO: set _customPaint to draw boundingRect on top of image
//       _customPaint = null;
//     }
//     _isBusy = false;
//     if (mounted) {
//       setState(() {});
//     }
//   }
// }
