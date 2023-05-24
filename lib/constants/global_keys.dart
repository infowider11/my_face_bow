import 'package:flutter/material.dart';

import '../pages/CameraPreviewPage.dart';
import '../pages/detected_image_view.dart';
import '../pages/home_page.dart';
import '../pages/sample_camera_view.dart';
import '../pages/vertical_relation/verticalReleationViewPage.dart';
import '../pages/vertical_relation/without_wax_camera_preview.dart';


class MyGlobalKeys{


  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<CameraPreviewPageState> cameraPreviewPageStateKey = GlobalKey<CameraPreviewPageState>();
  static final GlobalKey<CameraPreviewWithoutWaxState> cameraPreviewWithoutWaxState = GlobalKey<CameraPreviewWithoutWaxState>();
  static final GlobalKey<CameraPreviewWithoutWaxState> cameraPreviewWithWaxState = GlobalKey<CameraPreviewWithoutWaxState>();
  // static final GlobalKey<CameraViewState> cameraViewPageStateKey = GlobalKey<CameraViewState>();
  static final GlobalKey<DetectedImageViewState> detectedImageViewStateKey = GlobalKey<DetectedImageViewState>();
  static final GlobalKey<VerticalRelationPageViewPageState> verticalRelationPageViewPageKey = GlobalKey<VerticalRelationPageViewPageState>();
  static final GlobalKey<HomePageState> homePageStateKey = GlobalKey<HomePageState>();



}