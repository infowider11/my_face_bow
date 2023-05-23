
import 'package:flutter/material.dart';
import 'package:my_face_bow/constants/image_urls.dart';

import '../constants/colors.dart';
import '../constants/sized_box.dart';
import '../widgets/CustomTexts.dart';
class RecordingTheCentricRelation extends StatelessWidget {
  const RecordingTheCentricRelation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MyColors.lightBlueColor,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vSizedBox6,
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: (){
                    Navigator.pop(context);
                  }, child: Icon(Icons.arrow_back, color: Colors.white,),
                  behavior: HitTestBehavior.opaque,),
                  Expanded(
                      child: Center(
                        child: ParagraphText(
                          'Recording The Centric Relation',
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          fontSize: 20,
                        ),
                      )),
                ],
              ),
            ),
            vSizedBox2,
            // ParagraphText(
            //   'Lateral View',
            //   color: Colors.white,
            //   // textAlign: TextAlign.center,
            //   fontSize: 24,
            // ),
            vSizedBox,
            Center(child: Image.asset(MyImages.recordingTheCentralRelationImage, height: 200,)),
            vSizedBox4,
            vSizedBox,
            SubHeadingText('1. Make a V shaoe notches in the record rims. \n\n2. Apply a bite registration material. \n\n3. Ask the patient to close from posterior to anterior.', color: Colors.black,)

          ],
        ),
      ),
    );
  }
}
