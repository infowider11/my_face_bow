import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_face_bow/constants/colors.dart';
import 'package:my_face_bow/constants/sized_box.dart';
import 'package:my_face_bow/widgets/CustomTexts.dart';

import '../constants/global_data.dart';

class DetectedImageView extends StatelessWidget {
  final CustomPaint customPaint;
  final File file;
  const DetectedImageView(
      {Key? key, required this.customPaint, required this.file})
      : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: MyColors.primaryColor,

      body: Container(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                vSizedBox2,
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 20),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_rounded, color: Colors.white,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
                vSizedBox,
                Center(
                  child: Container(
                    // color: Colors.green.withOpacity(0.2),
                    height: globalAspectRatio*(MediaQuery.of(context).size.width),
                    width:MediaQuery.of(context).size.width,
                    child: customPaint!,),
                ),
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
