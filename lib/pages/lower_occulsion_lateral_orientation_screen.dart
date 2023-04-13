
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
          children: [
            vSizedBox6,
            Container(
              child: Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back, color: Colors.white,)),
                  Expanded(
                      child: Center(
                        child: ParagraphText(
                          'MyFaceBow',
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      )),
                ],
              ),
            ),
            vSizedBox2,
            Image.asset(MyImages.lowerOcculsionLateralOrientationIllustrationImage, height: 200,),
            vSizedBox2,
            SubHeadingText('Remember to adjust the posterior border of the lower record block to cover the lower 2/3 of the retromolar pad', color: Colors.red,)

          ],
        ),
      ),
    );
  }
}
