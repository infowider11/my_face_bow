import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_face_bow/constants/global_keys.dart';
import 'package:my_face_bow/painters/face_detector_painter.dart';

import '../modals/scenario_types.dart';
import '../widgets/showSnackbar.dart';

class GlobalProvider extends ChangeNotifier{
  File? file;

  CameraController? _controller;


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

}