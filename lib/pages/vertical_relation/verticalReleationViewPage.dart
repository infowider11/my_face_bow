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
import 'dart:ui' as ui;

import '../../constants/global_data.dart';
import '../../modals/scenario_types.dart';
import '../../widgets/round_edged_button.dart';


class VerticalRelationPageViewPage extends StatefulWidget {
  // final CustomPaint customPaint;
  final File fileWithWax;
  final File fileWithoutWax;
  const VerticalRelationPageViewPage({
    required Key key,
    // required this.customPaint,
    required this.fileWithWax,
    required this.fileWithoutWax,
  }) : super(key: key);

  @override
  State<VerticalRelationPageViewPage> createState() => VerticalRelationPageViewPageState();
}

class VerticalRelationPageViewPageState extends State<VerticalRelationPageViewPage> {

  @override
  void initState() {
    // TODO: implement initState

    try{
      Future.delayed(Duration(milliseconds: 400)).then((value) => setState((){}));
      Future.delayed(Duration(milliseconds: 600)).then((value) => setState((){}));
    }catch(e){
      print('Error in catch block 453 $e');
    }
    Future.delayed(Duration(milliseconds: 1500)).then((value) => setState((){}));

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(
        'the global is ${globalAspectRatio} annn ${(MediaQuery.of(context).size.width)}');
    print('the global h is ${MediaQuery.of(context).size.height}');


    print('both the painters are ${Provider.of<PaintProvider>(context, listen: false).customPaintForWax}  and ${Provider.of<PaintProvider>(context, listen: false).customPaintForWithoutWax}');
    print('the selected scenario is  ${Provider.of<GlobalProvider>(context, listen: false).selectedScenarios}  ');
    return Scaffold(
      backgroundColor: MyColors.lightBlueColor,
      body: Container(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                vSizedBox,
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
                vSizedBox05,
                Center(child: SubHeadingText('Vertical Relation', fontSize: 20,color: Colors.white,),),
                vSizedBox,
                Consumer<GlobalProvider>(
                  builder: (context, globalProvider, child) {
                    double difference = globalProvider.verticalRelationDistanceWithWax - globalProvider.verticalRelationDistanceWithoutWax;
                    if(difference<0){
                      difference = 0-difference;
                    }

                    if(difference<2){
                      return Center(child: SubHeadingText('Remove wax from lower record block', fontSize: 16,color: Colors.red,),);
                    }else if(difference>4){
                      return Center(child: SubHeadingText('Add wax to the lower record block', fontSize: 16,color: Colors.red,),);
                    }else{
                      return Center(child: SubHeadingText('', fontSize: 16,color: Colors.red,),);
                    }

                    // return Center(child: SubHeadingText('The difference between size is ${globalProvider.verticalRelationDistanceWithWax - globalProvider.verticalRelationDistanceWithoutWax} mm', fontSize: 16,color: Colors.red,),);
                  }
                ),

                vSizedBox,
                // ParagraphText('hhhhhhhh'),
                Center(
                  child: Consumer<PaintProvider>(
                      builder: (context, paintProvider, child) {
                        return Container(
                          color: Colors.green.withOpacity(0.2),
                          height: globalAspectRatio *
                              (MediaQuery.of(context).size.width)/2,
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height - 500,
                          // width: MediaQuery.of(context).size.height -
                          //     400 / globalAspectRatio,

                          child: paintProvider.customPaintForWithoutWax,
                        );
                      }),
                ),

                Center(
                  child: Consumer<PaintProvider>(
                      builder: (context, paintProvider, child) {
                        return Container(
                          color: Colors.black.withOpacity(0.2),
                          height: globalAspectRatio *
                              (MediaQuery.of(context).size.width)/2,
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height - 500,
                          // width: MediaQuery.of(context).size.height -
                          //     400 / globalAspectRatio,

                          child: paintProvider.customPaintForWax,
                        );
                      }),
                ),
                vSizedBox05,
                Consumer<GlobalProvider>(
                  builder: (context, globalProvider, child) {
                    if(globalProvider.selectedScenarios.isNotEmpty && globalProvider.selectedScenarios.first.scenarioType==ScenarioType.VERTICALRELATION)
                      return SizedBox();
                    return Center(
                      child: Consumer<PaintProvider>(
                          builder: (context, paintProvider, child) {
                            return RoundEdgedButton(
                              text: 'Save image to gallery',
                              horizontalMargin: 16,
                              width: 260,
                              verticalMargin: 0,
                              verticalPadding: 4,
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
                    );
                  }
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
