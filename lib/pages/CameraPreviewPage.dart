import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../constants/global_data.dart';
import '../functions/global_functions.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/showSnackbar.dart';

class CameraPreviewPage extends StatefulWidget {
  const CameraPreviewPage({required Key key}) : super(key: key);

  @override
  State<CameraPreviewPage> createState() => CameraPreviewPageState();
}

class CameraPreviewPageState extends State<CameraPreviewPage> with AutomaticKeepAliveClientMixin{


  int selectedCameraIndex = -1;
  CameraController? controller;
  bool enableAudio = true;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  XFile? imageFile;



  @override
  void initState() {
    // TODO: implement initState
    switchCamera(forceFrontCamera: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _cameraPreviewWidget(),
        Positioned(
          top: 32,
          right: 16,
          child: IconButton(
            icon: Icon(Icons.cameraswitch_sharp, color: Colors.white,),
            onPressed: ()async{
              await switchCamera();
              // setState(() {
              //
              // });
            },
          ),
        )
      ],
    );
  }


  Widget _cameraPreviewWidget() {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return Row(
        children: [
          Expanded(
              child: SubHeadingText(
                'Tap a Camera',
                color: Colors.white,
                textAlign: TextAlign.center,
              )
          ),
        ],
      );
    } else {
      return CameraPreview(
        controller!,

        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                // onScaleStart: _handleScaleStart,
                // onScaleUpdate: _handleScaleUpdate,
                // onTapDown: (TapDownDetails details) =>
                //     onViewFinderTap(details, constraints),
              );
            }),
      );
    }
  }

  Future<void> switchCamera({bool forceFrontCamera = false}) async{
    if(cameras.isEmpty){
      SchedulerBinding.instance.addPostFrameCallback((_)  {
        showSnackbar('No camera found.');
      });
    }else{
      selectedCameraIndex = (selectedCameraIndex +1)%cameras.length;

      await onNewCameraSelected(cameras[selectedCameraIndex], forceFrontCamera: forceFrontCamera);
    }
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription, {bool forceFrontCamera = false}) async {

    if(forceFrontCamera){
      if(cameras[selectedCameraIndex].lensDirection!=CameraLensDirection.front){
        selectedCameraIndex = (selectedCameraIndex +1)%cameras.length;
        await onNewCameraSelected(cameras[selectedCameraIndex]);
        return;
      }
    }
    final CameraController? oldController = controller;
    if (oldController != null) {
      // `controller` needs to be set to null before getting disposed,
      // to avoid a race condition when we use the controller that is being
      // disposed. This happens when camera permission dialog shows up,
      // which triggers `didChangeAppLifecycleState`, which disposes and
      // re-creates the controller.
      controller = null;
      await oldController.dispose();
    }

    /// TODO: We can change resolution from here
     CameraController cameraController = CameraController(
      cameraDescription,
      kIsWeb ? ResolutionPreset.max : ResolutionPreset.medium,
      enableAudio: enableAudio,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );


    controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        showSnackbar(
            'Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
      await Future.wait(<Future<Object?>>[
        // The exposure mode is currently not supported on the web.
        ...!kIsWeb
            ? <Future<Object?>>[
          cameraController.getMinExposureOffset().then(
                  (double value) => _minAvailableExposureOffset = value),
          cameraController
              .getMaxExposureOffset()
              .then((double value) => _maxAvailableExposureOffset = value)
        ]
            : <Future<Object?>>[],
        cameraController
            .getMaxZoomLevel()
            .then((double value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((double value) => _minAvailableZoom = value),
      ]);
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          showSnackbar('You have denied camera access.');
          break;
        case 'CameraAccessDeniedWithoutPrompt':
        // iOS only
          showSnackbar('Please go to Settings app to enable camera access.');
          break;
        case 'CameraAccessRestricted':
        // iOS only
          showSnackbar('Camera access is restricted.');
          break;
        case 'AudioAccessDenied':
          showSnackbar('You have denied audio access.');
          break;
        case 'AudioAccessDeniedWithoutPrompt':
        // iOS only
          showSnackbar('Please go to Settings app to enable audio access.');
          break;
        case 'AudioAccessRestricted':
        // iOS only
          showSnackbar('Audio access is restricted.');
          break;
        default:
          showCameraException(e);
          break;
      }
    }

    if (mounted) {
      setState(() {});
    }
  }



  Future<File?> takePictureInFileFormat() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      showSnackbar('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return File(file.path);
    } on CameraException catch (e) {
      showCameraException(e);
      return null;
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
