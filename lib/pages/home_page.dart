import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:my_face_bow/constants/colors.dart';
import 'package:my_face_bow/constants/global_functions.dart';
import 'package:my_face_bow/constants/global_keys.dart';
import 'package:my_face_bow/constants/navigation_functions.dart';
import 'package:my_face_bow/functions/image_picker.dart';
import 'package:my_face_bow/pages/about_page.dart';
import 'package:my_face_bow/pages/detected_image_view.dart';
import 'package:my_face_bow/pages/side_drawer.dart';
import 'package:my_face_bow/painters/LinePainter.dart';
import 'package:my_face_bow/widgets/custom_full_page_loader.dart';
import 'package:my_face_bow/widgets/showSnackbar.dart';
import 'dart:ui' as ui;
import '../constants/global_data.dart';
import '../constants/sized_box.dart';
import '../modals/scenario_types.dart';
import '../painters/face_detector_painter.dart';
import '../widgets/CustomTexts.dart';
import 'CameraPreviewPage.dart';
import '../rough_pages/camera_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? file;
  bool load = false;
  List<ScenarioModal> selectedScenarios = [];
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
  CustomPaint? _customPaint;
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
            color: MyColors.primaryColor.withOpacity(0.9),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
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
                    return GestureDetector(
                      onTap: () async {
                        // if (selectedScenarios.contains(allScenarios[index])) {
                        //   selectedScenarios.remove(allScenarios[index]);
                        // } else {
                        //   selectedScenarios.add(allScenarios[index]);
                        // }
                        selectedScenarios = [];
                        selectedScenarios.add(allScenarios[index]);
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          vSizedBox2,
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                            color: selectedScenarios.contains(allScenarios[index])?MyColors.redColor:null,
                            child: SubHeadingText(
                              allScenarios[index].scenarioName,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.black,
          // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),

          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // if (_customPaint != null && file != null)
                  //   Expanded(
                  //       child: DetectedImageView(
                  //           customPaint: _customPaint!, file: file!))
                  // else
                    Expanded(
                        child: CameraPreviewPage(
                      key: MyGlobalKeys.cameraPreviewPageStateKey,
                    )),
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
          color: MyColors.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () async {
                    push(context: context, screen: AboutUsPage());
                  },
                  child: Icon(
                    Icons.info,
                    size: 40,
                    color: Colors.white,
                  )),
              GestureDetector(
                onTap:load?null: () async {
                 if(selectedScenarios.length==0){
                   showSnackbar('Please select the scenarios');
                   // _scaffoldStateKey.currentState?.openEndDrawer();
                 }else if(selectedScenarios[0].scenarioType!=ScenarioType.TWOPARRALLELLINES){
                   showSnackbar('Coming Soon');
                 }else{
                   setState(() {
                     load = true;
                   });
                   file = await MyGlobalKeys
                       .cameraPreviewPageStateKey.currentState
                       ?.takePictureInFileFormat();
                   if (file != null) {
                     // InputImage inputImage = InputImage.fromFilePath(file!.path);

                     bool result = await processImage(file!);
                     if(result){
                       await push(context: context, screen: DetectedImageView(customPaint: _customPaint!, file: file!));
                     }else{
                       showSnackbar('No Face Found. Please retry');
                     }

                     // push(context: context, screen: DetectedImageView(customPaint: _customPaint!, file: file!))
                   }
                   setState(() {
                     load = false;
                   });
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
                          color: MyColors.primaryColor.withOpacity(0.6),
                        ),
                      ),
                      if(load)
                      Positioned(
                        top: 20,
                        right: 20,
                        bottom: 20,
                        left: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        )
                      )
                    ],
                  ),
                ),
              ),
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

  Future<bool> processImage(File tempFile) async {
    InputImage inputImage = InputImage.fromFile(tempFile!);
    print('processing image 10');
    // showSnackbar('Processing image');
    if (!_canProcess) return false;
    if (_isBusy) return false;
    _isBusy = true;
    // setState(() {
    //   _text = '';
    // });
    List<Face> faces = await _faceDetector.processImage(inputImage);

    if(faces.length==0){
      return false;
    }
    print('the faces are ${faces}');
    ui.Image imageFormatFile = await loadUiImage(file!.readAsBytesSync());
    // showSnackbar('the detected faces are ${faces.length}');
    print(
        ' dddddddddd ${inputImage.inputImageData?.size != null} and ${inputImage.inputImageData?.imageRotation != null}');

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      print('inside if');
      final painter = FaceDetectorPainter(
          faces,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation,
          imageFormatFile);
      _customPaint = CustomPaint(painter: painter);
    } else {
      print('inside else ${inputImage.inputImageData?.imageRotation}');
      // String text = 'Faces found: ${faces.length}\n\n';
      print('the height and width of painter is ${globalWidth}');
      final painter = FaceDetectorPainter(
        faces,
        Size(globalWidth, globalHeight),
        InputImageRotation.rotation0deg,
        imageFormatFile,
      );
      _customPaint = CustomPaint(painter: painter);
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
