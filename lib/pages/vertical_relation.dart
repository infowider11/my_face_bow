import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:my_face_bow/pages/vertical_relation/verticalReleationViewPage.dart';
import 'package:my_face_bow/pages/vertical_relation/without_wax_camera_preview.dart';
import 'package:my_face_bow/widgets/CustomTexts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/global_data.dart';
import '../constants/global_functions.dart';
import '../constants/global_keys.dart';
import '../constants/navigation_functions.dart';
import '../functions/global_functions.dart';
import '../painters/face_detector_painter.dart';
import '../providers/PaintProvider.dart';
import '../providers/global_provider.dart';
import '../widgets/showSnackbar.dart';
import 'detected_image_view.dart';
import 'dart:ui' as ui;

class VerticalRelationPage extends StatefulWidget {
  const VerticalRelationPage({Key? key}) : super(key: key);

  @override
  State<VerticalRelationPage> createState() => _VerticalRelationPageState();
}

class _VerticalRelationPageState extends State<VerticalRelationPage> {



  // bool isWithoutWaxTaken = false;
  File? fileWithoutWax;
  File? fileWithWax;
  bool load = false;


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


  Future<bool> processImageWithoutWax(InputImage inputImage,{bool fromCamera = false}
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
      Provider.of<PaintProvider>(context, listen: false).updateCustomPainterForWithoutWax(CustomPaint(painter: null),null);
      _isBusy = false;
      return false;
    }
    print('hello___1_${DateTime.now().millisecondsSinceEpoch}');
    ui.Image? imageFormatFile;
    if(!fromCamera){
      print('the image is not from camera');
      imageFormatFile = await loadUiImage(fileWithoutWax!.readAsBytesSync());
    }

    // showSnackbar('the detected faces are ${faces.length}');
    // print(
    //     ' dddddddddd ${inputImage.inputImageData?.size != null} and ${inputImage.inputImageData?.imageRotation != null}');

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      // print('inside if');
      print('the faces are ${faces.length} in without');
      final painter = FaceDetectorPainter(
        faces,
        inputImage.inputImageData!.size,
        inputImage.inputImageData!.imageRotation,
        // image: null,
        image: imageFormatFile,
        withoutWax: true,
      );

      print('hello____${DateTime.now().millisecondsSinceEpoch}');

      Provider.of<PaintProvider>(context, listen: false).updateCustomPainterForWithoutWax(CustomPaint(painter: painter), painter);
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
        withoutWax: true,
        /// revert this if have any error
        // image: null,
        image: imageFormatFile,

      );
      Provider.of<PaintProvider>(context, listen: false).updateCustomPainterForWithoutWax(CustomPaint(painter: painter), painter);
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



  Future<bool> processImageWithWax(InputImage inputImage,{bool fromCamera = false}
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
      Provider.of<PaintProvider>(context, listen: false).updateCustomPainterForWax(CustomPaint(painter: null),null);
      _isBusy = false;
      return false;
    }
    print('hello___1_${DateTime.now().millisecondsSinceEpoch}');
    ui.Image? imageFormatFile;
    if(!fromCamera){
      print('the image is not from camera');
      imageFormatFile = await loadUiImage(fileWithWax!.readAsBytesSync());
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
        withoutWax: false,
      );

      print('hello____${DateTime.now().millisecondsSinceEpoch}');

      Provider.of<PaintProvider>(context, listen: false).updateCustomPainterForWax(CustomPaint(painter: painter), painter);
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
        withoutWax: false,
      );
      Provider.of<PaintProvider>(context, listen: false).updateCustomPainterForWax(CustomPaint(painter: painter), painter);
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  fileWithoutWax!=null?
                  Container(child: Center(child: Image.file(fileWithoutWax!)),):
                  CameraPreviewWithoutWax(
                    key: MyGlobalKeys.cameraPreviewWithoutWaxState,
                    // customPaint: _customPaint,
                    onImage: (
                      inputImage,
                    ) {
                      // processImage(inputImage, fromCamera: true);
                    },
                  ),
                  if(fileWithoutWax==null)
                  Positioned(
                    top: 20, right: 0, left: 0,
                    child: ParagraphText('Take photo without wax', textAlign: TextAlign.center,),
                  ),
                  if(fileWithoutWax==null)
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Consumer<GlobalProvider>(builder: (context, globalData, child) {
                      return GestureDetector(
                        onTap: load
                            ? null
                            : () async {

                            setState(() {
                              load = true;
                            });
                            await Provider.of<GlobalProvider>(context, listen: false).controller!.stopImageStream();
                            try{
                              await Provider.of<PaintProvider>(context, listen: false).updateCustomPainterForWithoutWax(null, null);
                              fileWithoutWax = await MyGlobalKeys
                                  .cameraPreviewWithoutWaxState.currentState
                                  ?.takePictureInFileFormat();

                              if (fileWithoutWax != null) {
                                // InputImage inputImage = InputImage.fromFilePath(file!.path);

                                Directory path =
                                await getApplicationSupportDirectory();
                                print('the path is __________${path.path}');

                                fileWithoutWax = await testCompressAndGetFile(
                                    fileWithoutWax!, path.path + '/temp${DateTime.now()}.jpg');
                                print('the compressed image is $fileWithoutWax');


                                InputImage inputImage =
                                InputImage.fromFile(fileWithoutWax!);

                                bool result = await processImageWithoutWax(inputImage!);
                                print('the result is now $result');
                                globalData.photoErrorCounter = 0;
                                if (result) {
                                  setState(() {

                                  });
                                } else {
                                  showSnackbar('No Face Found. Please retry');
                                  fileWithoutWax = null;
                                }


                                // push(context: context, screen: DetectedImageView(customPaint: _customPaint!, file: file!))
                              }
                            }catch(e){

                            }
                            setState(() {
                              load = false;
                            });
                            await Provider.of<GlobalProvider>(context, listen: false).controller!.startImageStream(MyGlobalKeys.cameraPreviewWithoutWaxState.currentState!.processCameraImage);

                        },
                        child: Center(
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
                  ),

                ],
              ),
            ),
            Expanded(
              child:Stack(
                children: [
                  fileWithoutWax==null?
                  Container(child: Center(child: ParagraphText('Photo With Wax')),):
                  CameraPreviewWithoutWax(
                    key: MyGlobalKeys.cameraPreviewWithWaxState,
                    // customPaint: _customPaint,
                    onImage: (
                      inputImage,
                    ) {
                      // processImage(inputImage, fromCamera: true);
                    },
                  ),

                  if(fileWithoutWax!=null)
                    Positioned(
                      top: 20, right: 0, left: 0,
                      child: ParagraphText('Take photo with wax', textAlign: TextAlign.center,),
                    ),
                  if(fileWithoutWax!=null)
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Consumer<GlobalProvider>(builder: (context, globalData, child) {
                        return GestureDetector(
                          onTap: load
                              ? null
                              : () async {
                            setState(() {
                              load = true;
                            });
                            await Provider.of<GlobalProvider>(context, listen: false).controller!.stopImageStream();
                            try{
                              await Provider.of<PaintProvider>(context, listen: false).updateCustomPainterForWax(null, null);
                              fileWithWax = await MyGlobalKeys
                                  .cameraPreviewWithWaxState.currentState
                                  ?.takePictureInFileFormat();

                              if (fileWithWax != null) {
                                // InputImage inputImage = InputImage.fromFilePath(file!.path);

                                Directory path =
                                await getApplicationSupportDirectory();
                                print('the path is __________${path.path}');

                                fileWithWax = await testCompressAndGetFile(
                                    fileWithWax!, path.path + '/temp${DateTime.now()}.jpg');
                                print('the compressed image is $fileWithWax');


                                InputImage inputImage =
                                InputImage.fromFile(fileWithWax!);

                                bool result = await processImageWithWax(inputImage!);
                                print('the result is now $result');
                                globalData.photoErrorCounter = 0;
                                if (result) {
                                  await push(context: context, screen: VerticalRelationPageViewPage(fileWithoutWax: fileWithoutWax!, fileWithWax: fileWithWax!, key: MyGlobalKeys.verticalRelationPageViewPageKey,));
                                  // await push(
                                  //     context: context,
                                  //     screen: DetectedImageView(
                                  //         key: MyGlobalKeys
                                  //             .detectedImageViewStateKey,
                                  //         // customPaint: _customPaint!,
                                  //         file: fileWithWax!));
                                } else {
                                  showSnackbar('No Face Found. Please retry');
                                }
                              }
                            }catch(e){

                            }
                            setState(() {
                              load = false;
                            });
                            await Provider.of<GlobalProvider>(context, listen: false).controller!.startImageStream(MyGlobalKeys.cameraPreviewWithWaxState.currentState!.processCameraImage);
                          },
                          child: Center(
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
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
