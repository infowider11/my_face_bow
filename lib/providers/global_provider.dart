import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:my_face_bow/constants/global_keys.dart';
import 'package:my_face_bow/painters/face_detector_painter.dart';
import 'package:provider/provider.dart';

import '../constants/global_data.dart';
import '../constants/global_functions.dart';
import '../modals/scenario_types.dart';
import '../widgets/showSnackbar.dart';
import 'PaintProvider.dart';
import 'dart:ui' as ui;
class GlobalProvider extends ChangeNotifier{
  File? file;

  CameraController? _controller;
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );

  double nasoLabialAngle = 0;
  double facialProfileAngle = 0;
  double _verticalRelationDistanceWithWax = 0;
  double _verticalRelationDistanceWithoutWax = 0;


  double get verticalRelationDistanceWithWax =>
      _verticalRelationDistanceWithWax;

  double get verticalRelationDistanceWithoutWax =>
      _verticalRelationDistanceWithoutWax;

  changeVerticalRelationDistance(bool withoutWax, double distance){
    if(withoutWax){
      _verticalRelationDistanceWithoutWax = distance;
    }else{
      _verticalRelationDistanceWithWax = distance;
    }

    // notifyListeners();
  }

  changeNasoLabialAngle(double angle){
    if(nasoLabialAngle!=angle){
      nasoLabialAngle = angle;
      // notifyListeners();
    }



  }

  changeFacialProfileAngle(double angle){
    if(facialProfileAngle!=angle){
      facialProfileAngle = angle;
      // notifyListeners();
    }



  }


  CameraController? get controller => _controller;

  updateCameraController(CameraController? controller){
    if(_controller!=null){
      _controller!.dispose();
      _controller= null;
    }
    _controller = controller;
    notifyListeners();
  }



  int photoErrorCounter = 0;
  List<ScenarioModal> _selectedScenarios = [];


  List<ScenarioModal> get selectedScenarios => _selectedScenarios;

  updateScenario(List<ScenarioModal> newScenarios){
    _selectedScenarios = newScenarios;
    notifyListeners();
  }

  showError()async{
    photoErrorCounter++;
    print(' imkldklsflkjasfls');
    // if(errorCount)
    await Future.delayed(Duration(seconds: 2));
    showSnackbar('The measurements may be wrong. Please put your face in a straight position', seconds: 3);
    // ScaffoldMessenger.of(MyGlobalKeys.detectedImageViewStateKey.currentContext!).showSnackBar(SnackBar(content: Text('hello')));
    notifyListeners();
  }



// bool _canProcess = true;
  // bool _isBusy = false;
  // Future<bool> processImage(InputImage inputImage,{bool fromCamera = false}
  //     ) async {
  //
  //   print('The is busy is $_isBusy and can process is $_canProcess');
  //   // // print('processing image 10 $_canProcess $_isBusy');
  //   // // showSnackbar('Processing image');
  //   // if (!_canProcess) return false;
  //   // // if (_isBusy) return false;
  //   // // _isBusy = true;
  //   // // setState(() {
  //   // //   _text = '';
  //   // // });
  //   //
  //   if (!_canProcess) return false;
  //   // if (_isBusy) return false;
  //   _isBusy = true;
  //   List<Face> faces = [];
  //   // if (cameraImage != null) {
  //   //   faces = await detect(cameraImage, InputImageRotation.rotation0deg);
  //   // }
  //   // else {
  //   faces = await _faceDetector.processImage(inputImage);
  //   // }
  //
  //   print('the faces are provider page ${faces}');
  //
  //   if (faces.length == 0) {
  //     Provider.of<PaintProvider>(MyGlobalKeys.navigatorKey.currentContext!, listen: false).updateCustomPainter(CustomPaint(painter: null),null);
  //     _isBusy = false;
  //     return false;
  //   }
  //   print('hello___1_${DateTime.now().millisecondsSinceEpoch}');
  //   ui.Image? imageFormatFile;
  //   if(!fromCamera){
  //     print('the image is not from camera');
  //     print('sunaaye 1');
  //     Uint8List fileAsBytes = await  file!.readAsBytes();
  //     print('sunaaye 0.01');
  //     imageFormatFile = await loadUiImage(fileAsBytes);
  //     print('sunaaye 0.1');
  //   }
  //
  //   // showSnackbar('the detected faces are ${faces.length}');
  //   // print(
  //   //     ' dddddddddd ${inputImage.inputImageData?.size != null} and ${inputImage.inputImageData?.imageRotation != null}');
  //
  //   if (inputImage.inputImageData?.size != null &&
  //       inputImage.inputImageData?.imageRotation != null) {
  //     print('inside if');
  //     final painter = FaceDetectorPainter(
  //       faces,
  //       inputImage.inputImageData!.size,
  //       inputImage.inputImageData!.imageRotation,
  //       image: imageFormatFile,
  //     );
  //
  //     print('hello____${DateTime.now().millisecondsSinceEpoch}');
  //
  //     Provider.of<PaintProvider>(MyGlobalKeys.navigatorKey.currentContext!, listen: false).updateCustomPainter(CustomPaint(painter: painter), painter);
  //     print('hello____${DateTime.now().millisecondsSinceEpoch}');
  //     // _customPaint = CustomPaint(painter: painter);
  //   } else {
  //     // print('inside else ${inputImage.inputImageData?.imageRotation}');
  //     // String text = 'Faces found: ${faces.length}\n\n';
  //     print('the height and width of painter is ${globalWidth}');
  //     final painter = FaceDetectorPainter(
  //       faces,
  //       Size(globalWidth, globalHeight),
  //       InputImageRotation.rotation0deg,
  //       image: imageFormatFile,
  //     );
  //     print('sunaaye 1');
  //     Provider.of<PaintProvider>(MyGlobalKeys.navigatorKey.currentContext!, listen: false).updateCustomPainter(CustomPaint(painter: painter), painter);
  //     print('sunaaye 2');
  //     // _customPaint = CustomPaint(painter: painter);
  //     // for (final face in faces) {
  //     //   text += 'face: ${face.boundingBox}\n\n';
  //     // }
  //     // _text = text;
  //     // TODO: set _customPaint to draw boundingRect on top of image
  //     // _customPaint = null;
  //   }
  //   _isBusy = false;
  //   // if (mounted) {
  //   //   setState(() {});
  //   // }
  //   return true;
  // }

}