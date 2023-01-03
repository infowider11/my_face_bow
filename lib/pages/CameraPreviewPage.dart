import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:my_face_bow/constants/colors.dart';
import 'package:my_face_bow/constants/image_urls.dart';
import 'package:my_face_bow/providers/PaintProvider.dart';
import 'package:my_face_bow/providers/global_provider.dart';
import 'package:provider/provider.dart';

import '../constants/global_data.dart';
import '../constants/global_functions.dart';
import '../functions/global_functions.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/showSnackbar.dart';
import 'dart:ui' as ui ;

class CameraPreviewPage extends StatefulWidget {
  final Function( InputImage inputImage) onImage;
  // final CustomPaint? customPaint;
  const CameraPreviewPage({
    required Key key,
    required this.onImage,
    // this.customPaint
  }) : super(key: key);

  @override
  State<CameraPreviewPage> createState() => CameraPreviewPageState();
}

class CameraPreviewPageState extends State<CameraPreviewPage>
    with AutomaticKeepAliveClientMixin {
  int selectedCameraIndex = -1;
  // CameraController? controller;
  bool enableAudio = true;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  XFile? imageFile;

  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    switchCamera(forceFrontCamera: true);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    setState(() {

    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _cameraPreviewWidget(),
        Consumer<PaintProvider>(builder: (context, globalData, child){
          if(globalData.customPaint==null)
          return Container();
          return globalData.customPaint!;
        }),
        // if (widget.customPaint != null) widget.customPaint!,
        Positioned(
          top: 32,
          right: 16,
          child: IconButton(
            icon: Icon(
              Icons.cameraswitch_sharp,
              color: Colors.white,
            ),
            onPressed: () async {
              await switchCamera();
              // setState(() {
              //
              // });
            },
          ),
        ),
        // Positioned(
        //   left: 32,
        //   right: 32,
        //   top: 22,
        //   bottom: 22,
        //   child: Image.asset(MyImages.faceSkeleton, color: MyColors.primaryColor,),
        // )
      ],
    );
  }

  Widget _cameraPreviewWidget() {
    // final CameraController? cameraController = controller;

    if (Provider.of<GlobalProvider>(context, listen: false).controller == null || !(Provider.of<GlobalProvider>(context, listen: false).controller==null?true:Provider.of<GlobalProvider>(context, listen: false).controller!.value.isInitialized)) {
      return Row(
        children: [
          Expanded(
              child: SubHeadingText(
            'Tap a Camera',
            color: Colors.white,
            textAlign: TextAlign.center,
          )),
        ],
      );
    } else {
      return Consumer<GlobalProvider>(
        builder: (context, globalProvider, child) {
          return CameraPreview(
            globalProvider.controller!,
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
      );
    }
  }

  Future<void> switchCamera({bool forceFrontCamera = false}) async {
    if (cameras.isEmpty) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showSnackbar('No camera found.');
      });
    } else {
      selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length;

      await onNewCameraSelected(cameras[selectedCameraIndex],
          forceFrontCamera: forceFrontCamera);
    }
  }
  //
  // Future _processCameraImage(CameraImage image) async {
  //   print('inside process camera image $image');
  //   final WriteBuffer allBytes = WriteBuffer();
  //   for (final Plane plane in image.planes) {
  //     allBytes.putUint8List(plane.bytes);
  //   }
  //   print('1111111111111');
  //   final bytes = allBytes.done().buffer.asUint8List();
  //   print('11111111111112');
  //   final Size imageSize =
  //       Size(image.width.toDouble(), image.height.toDouble());
  //   print('11111111111113');
  //   final camera = cameras[selectedCameraIndex];
  //   print('11111111111114');
  //   final imageRotation =
  //       InputImageRotationValue.fromRawValue(camera.sensorOrientation);
  //   // print('1111111111115');
  //   // if (imageRotation == null) return;
  //   //
  //   // final inputImageFormat =
  //   //     InputImageFormatValue.fromRawValue(image.format.raw);
  //   //
  //   // print('the input format is $inputImageFormat');
  //   // if (inputImageFormat == null) return;
  //
  //   final planeData = image.planes.map(
  //     (Plane plane) {
  //       return InputImagePlaneMetadata(
  //         bytesPerRow: plane.bytesPerRow,
  //         height: plane.height,
  //         width: plane.width,
  //       );
  //     },
  //   ).toList();
  //   // ui.Image imageFormatFile = await loadUiImage(bytes);
  //   // nv21
  //   final inputImageData = InputImageData(
  //     size: Size(globalWidth, globalHeight),
  //     imageRotation: imageRotation??InputImageRotation.rotation0deg,
  //     inputImageFormat: InputImageFormatValue.fromRawValue(image.format.raw)??InputImageFormat.yv12,
  //     // inputImageFormat: inputImageFormat,
  //     planeData: planeData,
  //   );
  //
  //   final inputImage =
  //       InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
  //   // final inputI = InputImage.
  //
  //   print('inside process camera input image $inputImage');
  //
  //   widget.onImage(image, inputImage);
  // }

  Future processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
    Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[selectedCameraIndex];
    final imageRotation =
    InputImageRotationValue.fromRawValue(camera.sensorOrientation);




    // final inputImageFormat =
    // InputImageFormatValue.fromRawValue(image.format.raw)??InputImageFormat.yuv_420_888;
    // print('the image format is ${inputImageFormat}');
    if (imageRotation == null) return;
    // if (inputImageFormat == null) return;

    final planeData = image.planes.map(
          (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: InputImageFormatValue.fromRawValue(image.format.raw)??InputImageFormat.yuv_420_888,
      planeData: planeData,
    );



    widget.onImage(InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData));
  }



  Future<void> onNewCameraSelected(CameraDescription cameraDescription,
      {bool forceFrontCamera = false}) async {
    if (forceFrontCamera) {
      if (cameras[selectedCameraIndex].lensDirection !=
          CameraLensDirection.front) {
        selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length;
        await onNewCameraSelected(cameras[selectedCameraIndex]);
        return;
      }
    }
    // final CameraController? oldController = controller;
    if (Provider.of<GlobalProvider>(context, listen: false).controller != null) {
      // `controller` needs to be set to null before getting disposed,
      // to avoid a race condition when we use the controller that is being
      // disposed. This happens when camera permission dialog shows up,
      // which triggers `didChangeAppLifecycleState`, which disposes and
      // re-creates the controller.
      try{
        await Provider.of<GlobalProvider>(context, listen: false).controller?.stopImageStream();
      }catch(e){
        print('Error in catch block 895495  $e');
      }
      await Provider.of<GlobalProvider>(context, listen: false).controller?.dispose();
      Provider.of<GlobalProvider>(context, listen: false).updateCameraController(null);


      /// image streaming code

    }

    /// TODO: We can change resolution from here
    Provider.of<GlobalProvider>(context, listen: false).updateCameraController(CameraController(
      cameraDescription,
      kIsWeb ? ResolutionPreset.max : ResolutionPreset.medium,
      enableAudio: false,
      // imageFormatGroup: ImageFormatGroup.jpeg,

    ));


    // controller = cameraController;

    // If the controller is updated then update the UI.
    await  Provider.of<GlobalProvider>(context, listen: false).controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      Provider.of<GlobalProvider>(context, listen: false).controller?.getMinZoomLevel().then((value) {
        zoomLevel = value;
        minZoomLevel = value;
      });
      Provider.of<GlobalProvider>(context, listen: false).controller?.getMaxZoomLevel().then((value) {
        maxZoomLevel = value;
      });
      Provider.of<GlobalProvider>(context, listen: false).controller?.startImageStream(processCameraImage);
      setState(() {});
    });
    Provider.of<GlobalProvider>(context, listen: false).controller!.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (Provider.of<GlobalProvider>(context, listen: false).controller!.value.hasError) {
        showSnackbar('Camera error ${Provider.of<GlobalProvider>(context, listen: false).controller!.value.errorDescription}');
      }
    });

    try {
      // await cameraController.initialize();



      // /// image streaming code
      // cameraController?.getMinZoomLevel().then((value) {
      //   zoomLevel = value;
      //   minZoomLevel = value;
      // });
      // cameraController?.getMaxZoomLevel().then((value) {
      //   maxZoomLevel = value;
      // });
      // print('starting image streaming');
      // cameraController?.startImageStream(_processCameraImage);

      ///
      setState(() {});
      await Future.wait(<Future<Object?>>[
        // The exposure mode is currently not supported on the web.
        ...!kIsWeb
            ? <Future<Object?>>[
          Provider.of<GlobalProvider>(context, listen: false).controller!.getMinExposureOffset().then(
                    (double value) => _minAvailableExposureOffset = value),
          Provider.of<GlobalProvider>(context, listen: false).controller!
                    .getMaxExposureOffset()
                    .then((double value) => _maxAvailableExposureOffset = value)
              ]
            : <Future<Object?>>[],
        Provider.of<GlobalProvider>(context, listen: false).controller!
            .getMaxZoomLevel()
            .then((double value) => _maxAvailableZoom = value),
        Provider.of<GlobalProvider>(context, listen: false).controller!
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
    // final CameraController? cameraController = Provider.of<GlobalProvider>(context, listen: false).controller;
    if (Provider.of<GlobalProvider>(context, listen: false).controller == null || !Provider.of<GlobalProvider>(context, listen: false).controller!.value.isInitialized) {
      showSnackbar('Error: select a camera first.');
      return null;
    }

    print('I am listening.....2');
    if (Provider.of<GlobalProvider>(context, listen: false).controller!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      print('I am listening.....2');
      final XFile file = await Provider.of<GlobalProvider>(context, listen: false).controller!.takePicture();
      print('I am listening.....3');
      // await Provider.of<GlobalProvider>(context, listen: false).controller!.startImageStream(processCameraImage);
      print('I am listening.....4');
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
