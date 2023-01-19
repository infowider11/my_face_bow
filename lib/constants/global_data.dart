import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
List<CameraDescription> cameras = [];


/// 352x288 on iOS, 240p (320x240) on Android and Web
// low,

/// 480p (640x480 on iOS, 720x480 on Android and Web)
// medium,


/// current resolution is set to low
// double globalHeight = Platform.isAndroid?320:352;
// double globalWidth =  Platform.isAndroid?240:288;

/// resolution for medium
double globalHeight = Platform.isAndroid?720:640;
double globalWidth =  Platform.isAndroid?480:480;


ValueNotifier<double> amountOfTeethShowing = ValueNotifier(0);
// double m = globalHeight/globalWidth;
double globalAspectRatio = globalHeight/globalWidth;

// setGlobalAspectRatio(double ratio, double width){
//   globalAspectRatio = ratio;
//   globalWidth = width;
//   globalHeight = width/globalAspectRatio;
//   // m = ratio;
// }

