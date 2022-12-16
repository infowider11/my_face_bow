import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:my_face_bow/constants/colors.dart';
import 'package:my_face_bow/constants/navigation_functions.dart';
import 'package:my_face_bow/functions/image_picker.dart';
import 'package:my_face_bow/pages/detected_image_view.dart';
import 'package:my_face_bow/painters/LinePainter.dart';
import 'package:my_face_bow/widgets/showSnackbar.dart';

import '../painters/face_detector_painter.dart';
import '../widgets/CustomTexts.dart';
import 'camera_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? file;
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.black,
          // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_customPaint != null && file != null)
                Expanded(
                    child: DetectedImageView(
                        customPaint: _customPaint!, file: file!))
              else
                Center(
                  child: ParagraphText(
                    'Capture Image to get the Occlusal plane orientation.',
                    textAlign: TextAlign.center,
                    color: Colors.white,
                  ),
                )
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
                    file = await pickImage(true);
                  },
                  child: Icon(
                    Icons.info,
                    size: 40,
                    color: Colors.white,
                  )),
              GestureDetector(
                onTap: () async {
                  if(file==null){
                    file = await pickImage(false);
                  }

                  if (file != null) {
                    // InputImage inputImage = InputImage.fromFilePath(file!.path);
                    InputImage inputImage = InputImage.fromFile(file!);

                    print('the image is ss $inputImage');
                    await processImage(inputImage);
                    // List<Face> faces = await _faceDetector.processImage(inputImage);
                    // final painter = FaceDetectorPainter(
                    //     faces,
                    //     inputImage.inputImageData?.size??Size(400, 400),
                    //     inputImage.inputImageData!.imageRotation);
                    // _customPaint = CustomPaint(painter: painter);
                    setState(() {
                      print('hellow world');
                    });
                    // push(context: context, screen: DetectedImageView(customPaint: _customPaint!, file: file!));
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
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: ()async{
                  if(file!=null){
                    InputImage inputImage = InputImage.fromFile(file!);
                    await processImage(inputImage);
                    push(context: context, screen: DetectedImageView(customPaint: _customPaint!,
                        file: file!));
                  }else{
                    showSnackbar('Please select image');
                  }
                  
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

  Future<void> processImage(InputImage inputImage) async {
    print('processing image 10');
    // showSnackbar('Processing image');
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    // setState(() {
    //   _text = '';
    // });
    List<Face> faces = await _faceDetector.processImage(inputImage);
    print('the faces are ${faces}');
    // showSnackbar('the detected faces are ${faces.length}');
    print(
        ' dddddddddd ${inputImage.inputImageData?.size != null} and ${inputImage.inputImageData?.imageRotation != null}');
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      print('inside if');
      final painter = FaceDetectorPainter(
          faces,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      _customPaint = CustomPaint(painter: painter);
    } else {
      print('inside else ${inputImage.inputImageData?.imageRotation}');
      // String text = 'Faces found: ${faces.length}\n\n';
      print('the height and width of painter is ${MediaQuery.of(context).size.width}');
      final painter = FaceDetectorPainter(
          faces,
          Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.width),
          InputImageRotation.rotation0deg);
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
  }
}
