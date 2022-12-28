import 'package:flutter/material.dart';
import 'package:my_face_bow/constants/colors.dart';

import '../constants/sized_box.dart';
import '../widgets/CustomTexts.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightBlueColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              vSizedBox2,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: MyColors.primaryColor,
                      size: 30,
                    ),
                  ),
                  MainHeadingText(
                    'Info',
                    color: MyColors.primaryColor,
                    textDecoration: TextDecoration.underline,
                  ),
                  Container(
                    width: 30,
                    height: 30,
                  )
                ],
              ),
              vSizedBox2,
             Expanded(
               child: SingleChildScrollView(
                 physics: BouncingScrollPhysics(),
                 child: Column(
                   children: [
                     vSizedBox2,
                     Container(
                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(16)),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SubHeadingText(
                             'Equipments',
                             color: MyColors.primaryColor,
                           ),
                           vSizedBox2,
                           ParagraphText(
                             '1- Straight hand piece\n2- Acrylic bur\n3- Bowl + spatula\n4- Tongue depressor\n5- Wax knife\n6- Glass slap\n7- Torch\n8- Pink wax\n9- Boley gauge\n10- Adhesive\n11- Bite registration material\n12- Indelible pencil',
                             color: MyColors.primaryColor,
                             height: 1.4,
                           ),
                         ],
                       ),
                     ),
                     vSizedBox2,
                     Container(
                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(16)),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SubHeadingText(
                             'Something you need',
                             color: MyColors.primaryColor,
                           ),
                           vSizedBox2,
                           ParagraphText(
                             'First start by checking:\n\n1- retention of your record blocks on the cast and then on patient mouth.\n2- ensure that your block reaching into the full depth of the vestibule.\n3- check the frenula opening of your record base.',
                             color: MyColors.primaryColor,
                             height: 1.4,
                           ),
                         ],
                       ),
                     ),
                     vSizedBox2,
                     Container(
                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(16)),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SubHeadingText(
                             'Facebow steps:',
                             color: MyColors.primaryColor,
                           ),
                           vSizedBox2,
                           SubHeadingText(
                             '1-Modeling plastic is heated – 600, then Impression compound is attached to bite fork and It is positioned over the maxillary teeth\n2-after that, remove it from the mouth when cooled, chilled in water and check the adaptation in record base\n3-With bite fork in position face bow is guided onto the stem of the bite fork\n4-Earpiece into the external auditory openings\n5-Orbital pointer positioned\n6-Thumbscrews tightened to maintain the spatial relationships between face bow and bite fork',
                             color: MyColors.primaryColor,
                             height: 1.4,
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
             )
            ],
          ),
        ),
      ),
    );
  }
}
