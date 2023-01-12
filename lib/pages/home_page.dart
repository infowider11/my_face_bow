import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart'
    as dd;
import 'package:image_cropper/image_cropper.dart';
import 'package:my_face_bow/constants/colors.dart';
import 'package:my_face_bow/constants/global_functions.dart';
import 'package:my_face_bow/constants/global_keys.dart';
import 'package:my_face_bow/constants/navigation_functions.dart';
import 'package:my_face_bow/functions/global_functions.dart';
import 'package:my_face_bow/functions/image_picker.dart';
import 'package:my_face_bow/pages/about_page.dart';
import 'package:my_face_bow/pages/detected_image_view.dart';
import 'package:my_face_bow/pages/info_page.dart';
import 'package:my_face_bow/pages/sample_page.dart';
import 'package:my_face_bow/pages/side_drawer.dart';
import 'package:my_face_bow/painters/LinePainter.dart';
import 'package:my_face_bow/providers/PaintProvider.dart';
import 'package:my_face_bow/widgets/custom_full_page_loader.dart';
import 'package:my_face_bow/widgets/showSnackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import '../constants/global_data.dart';
import '../constants/sized_box.dart';
import '../modals/scenario_types.dart';
import '../painters/face_detector_painter.dart';
import '../providers/global_provider.dart';
import '../widgets/CustomTexts.dart';
import 'CameraPreviewPage.dart';
import '../rough_pages/camera_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({required Key key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  File? file;
  bool load = false;

  showErrorMessage() {
    if (Provider.of<GlobalProvider>(context, listen: false).photoErrorCounter ==
        0) {
      Provider.of<GlobalProvider>(context, listen: false).showError();
    }
  }

  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  // String? _text;

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();

    // List<Face> a = [];
    // Map<FaceLandmarkType, FaceLandmark?> landmarkes = a[0].landmarks;
    // var abc = landmarkes[FaceLandmarkType.noseBase];
    super.dispose();
  }

  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // setGlobalAspectRatio(MediaQuery.of(context).size.aspectRatio, MediaQuery.of(context).size.width);
    // print('the aspect ratio is ${globalAspectRatio} and width is ${MediaQuery.of(context).size.width}');
    return SafeArea(
      child: Scaffold(
        key: _scaffoldStateKey,
        endDrawer: Container(
          // width: MediaQuery.of(context).size.width-100,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          decoration: BoxDecoration(
            color: MyColors.lightBlueColor.withOpacity(0.9),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _scaffoldStateKey.currentState?.closeEndDrawer();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  MainHeadingText(
                    'Scenerio Selection',
                    color: Colors.white,
                  ),
                  Container(
                    width: 30,
                    height: 30,
                  )
                ],
              ),
              vSizedBox4,
              Expanded(
                child: ListView.builder(
                  itemCount: allScenarios.length,
                  itemBuilder: (context, index) {
                    return Consumer<GlobalProvider>(
                        builder: (context, globalData, child) {
                      return GestureDetector(
                        onTap: () async {
                          // if (selectedScenarios.contains(allScenarios[index])) {
                          //   selectedScenarios.remove(allScenarios[index]);
                          // } else {
                          //   selectedScenarios.add(allScenarios[index]);
                          // }
                          globalData.updateScenario([allScenarios[index]]);
                          // selectedScenarios = [];
                          // selectedScenarios.add(allScenarios[index]);
                          setState(() {});
                        },
                        child: Column(
                          children: [
                            vSizedBox2,
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4),
                              color: globalData.selectedScenarios
                                      .contains(allScenarios[index])
                                  ? MyColors.redColor
                                  : null,
                              child: SubHeadingText(
                                allScenarios[index].scenarioName,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: MyColors.lightBlueColor,
          width: MediaQuery.of(context).size.width,
          // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),

          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                          child: ParagraphText(
                        'MyFaceBow',
                        color: Colors.white,
                        fontSize: 24,
                      )),
                    ),
                  ),
                  // if (_customPaint != null && file != null)
                  //   Expanded(
                  //       child: DetectedImageView(
                  //           customPaint: _customPaint!, file: file!))
                  // else
                  AspectRatio(
                    aspectRatio: globalWidth / globalHeight,
                    child: Stack(
                      children: [
                        Container(
                          // height: globalHeight-100,
                          //   width: globalWidth,
                          // clipBehavior: Clip.antiAlias,
                          // child: FaceDetectorView(),
                          child: CameraPreviewPage(
                            key: MyGlobalKeys.cameraPreviewPageStateKey,
                            // customPaint: _customPaint,
                            onImage: (
                                inputImage,
                                ) {




                                processImage(inputImage, fromCamera: true);
                            },
                          ),

                        ),
                        // if (_customPaint != null) _customPaint!,
                      ],
                    ),
                  ),
                  // Center(
                  //   child: ParagraphText(
                  //     'Capture Image to get the Occlusal plane orientation.',
                  //     textAlign: TextAlign.center,
                  //     color: Colors.white,
                  //   ),
                  // )
                ],
              ),
              // if (load) CustomFullPageLoader(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 40),
          color: MyColors.lightBlueColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () async {
                    push(context: context, screen: InfoPage());
                  },
                  child: Icon(
                    Icons.info,
                    size: 40,
                    color: Colors.white,
                  )),
              Consumer<GlobalProvider>(builder: (context, globalData, child) {
                return GestureDetector(
                  onTap: load
                      ? null
                      : () async {
                          if (globalData.selectedScenarios.length == 0) {
                            showSnackbar('Please select the scenarios');
                            // _scaffoldStateKey.currentState?.openEndDrawer();
                          } else {
                            setState(() {
                              load = true;
                            });
                            await Provider.of<GlobalProvider>(context, listen: false).controller!.stopImageStream();
                            try{
                              await Provider.of<PaintProvider>(context, listen: false).updateCustomPainter(null);
                              file = await MyGlobalKeys
                                  .cameraPreviewPageStateKey.currentState
                                  ?.takePictureInFileFormat();

                              if (file != null) {
                                // InputImage inputImage = InputImage.fromFilePath(file!.path);

                                Directory path =
                                await getApplicationSupportDirectory();
                                print('the path is __________${path.path}');

                                file = await testCompressAndGetFile(
                                    file!, path.path + '/temp${DateTime.now()}.jpg');
                                print('the compressed image is $file');


                                InputImage inputImage =
                                InputImage.fromFile(file!);
                                bool result = await processImage(inputImage!);
                                globalData.photoErrorCounter = 0;
                                if (result) {
                                  await push(
                                      context: context,
                                      screen: DetectedImageView(
                                          key: MyGlobalKeys
                                              .detectedImageViewStateKey,
                                          // customPaint: _customPaint!,
                                          file: file!));
                                } else {
                                  showSnackbar('No Face Found. Please retry');
                                }


                                // push(context: context, screen: DetectedImageView(customPaint: _customPaint!, file: file!))
                              }
                            }catch(e){

                            }
                            setState(() {
                              load = false;
                            });
                            await Provider.of<GlobalProvider>(context, listen: false).controller!.startImageStream(MyGlobalKeys.cameraPreviewPageStateKey.currentState!.processCameraImage);

                          }
                        },
                  child: Container(
                    child: Stack(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 70,
                          color: Colors.white,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          bottom: 0,
                          left: 0,
                          child: Icon(
                            Icons.circle,
                            size: 60,
                            color: MyColors.lightBlueColor.withOpacity(0.6),
                          ),
                        ),
                        if (load)
                          Positioned(
                              top: 20,
                              right: 20,
                              bottom: 20,
                              left: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                      ],
                    ),
                  ),
                );
              }),
              GestureDetector(
                onTap: () async {
                  _scaffoldStateKey.currentState?.openEndDrawer();
                  // if (file != null) {
                  //   await processImage(file!);
                  //   push(
                  //       context: context,
                  //       screen: DetectedImageView(
                  //           customPaint: _customPaint!, file: file!));
                  // } else {
                  //   showSnackbar('Please select image');
                  // }
                },
                child: Icon(
                  Icons.settings,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Face>> detect(CameraImage image, InputImageRotation rotation) {
    // final faceDetector = GoogleMlKit.vision.faceDetector(
    //    FaceDetectorOptions(
    //     performanceMode: FaceDetectorMode.accurate,
    //     enableLandmarks: true,
    //   ),
    // );
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());
    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw) ??
            InputImageFormat.nv21;
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
      imageRotation: rotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    return _faceDetector.processImage(
      InputImage.fromBytes(
          // bytes: bytes,
          bytes: Uint8List.fromList(
            image.planes.fold(
                <int>[],
                (List<int> previousValue, element) =>
                    previousValue..addAll(element.bytes)),
          ),
          inputImageData: inputImageData,
      ),
    );
  }



  Future<bool> processImage(InputImage inputImage,{bool fromCamera = false}
     ) async {
    // // print('processing image 10 $_canProcess $_isBusy');
    // // showSnackbar('Processing image');
    // if (!_canProcess) return false;
    // // if (_isBusy) return false;
    // // _isBusy = true;
    // // setState(() {
    // //   _text = '';
    // // });
    //
    if (!_canProcess) return false;
    if (_isBusy) return false;
    _isBusy = true;
    List<Face> faces = [];
    // if (cameraImage != null) {
    //   faces = await detect(cameraImage, InputImageRotation.rotation0deg);
    // }
    // else {
      faces = await _faceDetector.processImage(inputImage);
    // }

    print('the faces are home page ${faces}');

    if (faces.length == 0) {
      Provider.of<PaintProvider>(context, listen: false).updateCustomPainter(CustomPaint(painter: null));
      _isBusy = false;
      return false;
    }
    print('hello___1_${DateTime.now().millisecondsSinceEpoch}');
    ui.Image? imageFormatFile;
if(!fromCamera){
  print('the image is not from camera');
  imageFormatFile = await loadUiImage(file!.readAsBytesSync());
}

    // showSnackbar('the detected faces are ${faces.length}');
    // print(
    //     ' dddddddddd ${inputImage.inputImageData?.size != null} and ${inputImage.inputImageData?.imageRotation != null}');

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      // print('inside if');
      final painter = FaceDetectorPainter(
          faces,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation,
          image: imageFormatFile,
      );

      print('hello____${DateTime.now().millisecondsSinceEpoch}');

      Provider.of<PaintProvider>(context, listen: false).updateCustomPainter(CustomPaint(painter: painter));
      print('hello____${DateTime.now().millisecondsSinceEpoch}');
      // _customPaint = CustomPaint(painter: painter);
    } else {
      // print('inside else ${inputImage.inputImageData?.imageRotation}');
      // String text = 'Faces found: ${faces.length}\n\n';
      // print('the height and width of painter is ${globalWidth}');
      final painter = FaceDetectorPainter(
        faces,
        Size(globalWidth, globalHeight),
        InputImageRotation.rotation0deg,
        image: imageFormatFile,
      );
      Provider.of<PaintProvider>(context, listen: false).updateCustomPainter(CustomPaint(painter: painter));
      // _customPaint = CustomPaint(painter: painter);
      // for (final face in faces) {
      //   text += 'face: ${face.boundingBox}\n\n';
      // }
      // _text = text;
      // TODO: set _customPaint to draw boundingRect on top of image
      // _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
    return true;
  }
}
