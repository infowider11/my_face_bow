
import 'package:flutter/material.dart';
import 'package:my_face_bow/constants/image_urls.dart';

import '../constants/colors.dart';
import '../constants/sized_box.dart';
import '../widgets/CustomTexts.dart';
class LowerOcculsionLateralOrientationScreen extends StatelessWidget {
  const LowerOcculsionLateralOrientationScreen({Key? key}) : super(key: key);

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
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back, color: Colors.white,)),
                  Expanded(
                      child: Center(
                        child: ParagraphText(
                          'Lower occlusal plane orientation ',
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          fontSize: 24,
                        ),
                      )),
                ],
              ),
            ),
            vSizedBox2,
            ParagraphText(
              'Lateral View',
              color: Colors.white,
              // textAlign: TextAlign.center,
              fontSize: 24,
            ),
            vSizedBox,
            Center(child: Image.asset(MyImages.lowerOcculsionLateralOrientationIllustrationImage, height: 200,)),
            vSizedBox2,
            SubHeadingText('Remember to adjust the posterior border of the lower record block to cover the lower 2/3 of the retromolar pad', color: Colors.black,)

          ],
        ),
      ),
    );
  }
}
