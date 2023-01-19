import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:my_face_bow/constants/colors.dart';
import 'package:my_face_bow/constants/sized_box.dart';
import 'package:my_face_bow/providers/PaintProvider.dart';
import 'package:my_face_bow/providers/global_provider.dart';
import 'package:my_face_bow/widgets/CustomTexts.dart';
import 'package:my_face_bow/widgets/showSnackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../constants/global_data.dart';
import 'dart:ui' as ui;

import '../modals/scenario_types.dart';
import '../widgets/round_edged_button.dart';

class DetectedImageView extends StatefulWidget {
  // final CustomPaint customPaint;
  final File file;
  const DetectedImageView({
    required Key key,
    // required this.customPaint,
    required this.file,
  }) : super(key: key);

  @override
  State<DetectedImageView> createState() => DetectedImageViewState();
}

class DetectedImageViewState extends State<DetectedImageView> {
  @override
  Widget build(BuildContext context) {
    print(
        'the global is ${globalAspectRatio} annn ${(MediaQuery.of(context).size.width)}');
    print('the global h is ${MediaQuery.of(context).size.height}');

    return Scaffold(
      backgroundColor: MyColors.lightBlueColor,
      body: Container(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                vSizedBox2,
                Consumer<PaintProvider>(
                    builder: (context, paintProvider, child) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        // IconButton(
                        //   icon: Icon(
                        //     Icons.arrow_downward_rounded,
                        //     color: Colors.white,
                        //   ),
                        //   onPressed: () async {
                        //     print('hhhhhh....1');
                        //     ui.PictureRecorder recorder = ui.PictureRecorder();
                        //     print('hhhhhh....2');
                        //     Canvas canvas = Canvas(recorder);
                        //     print('hhhhhh....3');
                        //     var painter = paintProvider.customPainter;
                        //     print('hhhhhh....4');
                        //     // height: globalAspectRatio*(MediaQuery.of(context).size.width),
                        //     // width:MediaQuery.of(context).size.width,
                        //     var size = Size(
                        //         MediaQuery.of(context).size.width,
                        //         globalAspectRatio *
                        //             (MediaQuery.of(context).size.width));
                        //     print('hhhhhh....5');
                        //     painter!.paint(canvas, size);
                        //     print('hhhhhh....6');
                        //     ui.Image renderedImage = await recorder
                        //         .endRecording()
                        //         .toImage(
                        //             size.width.floor(), size.height.floor());
                        //     print('hhhhhh....7');
                        //     var pngBytes = await renderedImage.toByteData(
                        //         format: ui.ImageByteFormat.png);
                        //     print('hhhhhh....8');
                        //
                        //     Directory saveDir =
                        //         await getApplicationDocumentsDirectory();
                        //     print('hhhhhh....9');
                        //     String path = '${saveDir.path}/custom_image.jpg';
                        //     print('hhhhhh....10');
                        //     File saveFile = File(path);
                        //     print('hhhhhh....11');
                        //
                        //     if (!saveFile.existsSync()) {
                        //       print('hhhhhh....12');
                        //       saveFile.createSync(recursive: true);
                        //     }
                        //     print('hhhhhh....13');
                        //     saveFile.writeAsBytesSync(
                        //         pngBytes!.buffer.asUint8List(),
                        //         flush: true);
                        //     print('hhhhhh....14');
                        //     try {
                        //       print('hhhhhh....15');
                        //       await GallerySaver.saveImage(path,
                        //           albumName: 'MyFaceBow');
                        //       print(
                        //           'hhhhhh....16 The file is saved at ${saveFile.path} also in gallary');
                        //       showSnackbar('The file is saved in your gallery');
                        //     } catch (e) {
                        //       print(
                        //           'hhhhhh....15 The file is saved at ${saveFile.path}');
                        //       showSnackbar('The file could not be saved($e)');
                        //       print('thjhh error is $e');
                        //     }
                        //   },
                        // ),
                      ],
                    ),
                  );
                }),
                vSizedBox,
                Center(
                  child: Consumer<PaintProvider>(
                      builder: (context, paintProvider, child) {
                    return Container(
                      // color: Colors.green.withOpacity(0.2),
                      height: globalAspectRatio *
                          (MediaQuery.of(context).size.width),
                      width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height - 500,
                      // width: MediaQuery.of(context).size.height -
                      //     400 / globalAspectRatio,

                      child: paintProvider.customPaint,
                    );
                  }),
                ),
                Consumer<GlobalProvider>(builder: (context, globalData, child) {
                  if (globalData.selectedScenarios.isNotEmpty) if (globalData
                          .selectedScenarios[0].scenarioType ==
                      ScenarioType.AMOUNTOFTEETHSHOWING)
                    return ValueListenableBuilder(
                        valueListenable: amountOfTeethShowing,
                        builder: (context, value, child) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Center(
                              child: SubHeadingText('${value.roundToDouble()}mm\n'+
                                  (value.roundToDouble()>1?value.roundToDouble()>2?
                                  'Please adjust your rim. It can not be more than 2mm':
                                '':
                                  'Please adjust your rim. It can not be less than 1mm'),
                                color:  value.roundToDouble()>1?value.roundToDouble()>2?Colors.red:Colors.black:Colors.red,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        });
                  return Container();
                }),
                Center(
                  child: Consumer<PaintProvider>(
                    builder: (context, paintProvider, child) {
                      return RoundEdgedButton(
                        text: 'Save image to gallery',
                        horizontalMargin: 16,
                        width: 260,
                        onTap: ()async{
                          print('hhhhhh....1');
                          ui.PictureRecorder recorder = ui.PictureRecorder();
                          print('hhhhhh....2');
                          Canvas canvas = Canvas(recorder);
                          print('hhhhhh....3');
                          var painter = paintProvider.customPainter;
                          print('hhhhhh....4');
                          // height: globalAspectRatio*(MediaQuery.of(context).size.width),
                          // width:MediaQuery.of(context).size.width,
                          var size = Size(
                              MediaQuery.of(context).size.width,
                              globalAspectRatio *
                                  (MediaQuery.of(context).size.width));
                          print('hhhhhh....5');
                          painter!.paint(canvas, size);
                          print('hhhhhh....6');
                          ui.Image renderedImage = await recorder
                              .endRecording()
                              .toImage(
                              size.width.floor(), size.height.floor());
                          print('hhhhhh....7');
                          var pngBytes = await renderedImage.toByteData(
                              format: ui.ImageByteFormat.png);
                          print('hhhhhh....8');

                          Directory saveDir =
                              await getApplicationDocumentsDirectory();
                          print('hhhhhh....9');
                          String path = '${saveDir.path}/custom_image.jpg';
                          print('hhhhhh....10');
                          File saveFile = File(path);
                          print('hhhhhh....11');

                          if (!saveFile.existsSync()) {
                            print('hhhhhh....12');
                            saveFile.createSync(recursive: true);
                          }
                          print('hhhhhh....13');
                          saveFile.writeAsBytesSync(
                              pngBytes!.buffer.asUint8List(),
                              flush: true);
                          print('hhhhhh....14');
                          try {
                            print('hhhhhh....15');
                            await GallerySaver.saveImage(path,
                                albumName: 'MyFaceBow');
                            print(
                                'hhhhhh....16 The file is saved at ${saveFile.path} also in gallary');
                            showSnackbar('The file is saved in your gallery');
                          } catch (e) {
                            print(
                                'hhhhhh....15 The file is saved at ${saveFile.path}');
                            showSnackbar('The file could not be saved($e)');
                            print('thjhh error is $e');
                          }
                        },
                      );
                    }
                  ),
                )
                // Stack(
                //   // fit: StackFit.expand,
                //   children: <Widget>[
                //     Image.file(
                //       file!,
                //       // fit: BoxFit.fill,
                //       alignment: Alignment.topLeft,
                //       height: globalAspectRatio*(MediaQuery.of(context).size.width - 50),
                //       width:MediaQuery.of(context).size.width - 50,
                //       fit: BoxFit.fitWidth,
                //     ),
                //     if (customPaint != null)
                //       Container(
                //         // color: Colors.green.withOpacity(0.2),
                //         height: globalAspectRatio*(MediaQuery.of(context).size.width - 50),
                //            width:MediaQuery.of(context).size.width - 50,
                //           child: customPaint!,),
                //
                //     // if (customPaint != null)
                //     //   Align(
                //     //     alignment: Alignment.center,
                //     //     child: customPaint!,
                //     //   ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
