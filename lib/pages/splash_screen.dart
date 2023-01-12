import 'package:flutter/material.dart';
import 'package:my_face_bow/constants/colors.dart';
import 'package:my_face_bow/constants/global_keys.dart';
import 'package:my_face_bow/constants/image_urls.dart';
import 'package:my_face_bow/constants/navigation_functions.dart';
import 'package:my_face_bow/constants/sized_box.dart';
import 'package:my_face_bow/pages/home_page.dart';
import 'package:my_face_bow/widgets/CustomTexts.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  pushToHomePage()async{
    await Future.delayed(Duration(seconds: 2)).then((value){

    });
    await push(context: context, screen: HomePage(key: MyGlobalKeys.homePageStateKey,));
    pushToHomePage();

  }

  @override
  void initState() {
    // TODO: implement initState
    pushToHomePage();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print('did change dependency');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MyColors.whiteColor,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Image.asset(MyImages.appLogo, height: MediaQuery.of(context).size.height*3/9,fit: BoxFit.fitHeight,),
            ),
            vSizedBox,
            ParagraphText('MyFacebow', color: MyColors.primaryColor, fontSize: 30,),
            vSizedBox2,
          ],
        ),
      ),
    );
  }
}


//
//
// double upperRimLinex1 = lowerLipBottom!.points[1].x.toDouble();
// double upperRimLiney1 = lowerLipBottom!.points[1].y.toDouble();
// double upperRimLinex2 = upperLipTop!
//     .points[upperLipTop!.points.length - 2].x
//     .toDouble();
// double upperRimLiney2 = upperLipTop!
//     .points[upperLipTop!.points.length - 2].y
//     .toDouble();
//
// drawSideFaceLine(
// x1: upperRimLinex1,
// y1: upperRimLiney1,
// x2: upperRimLinex2,
// y2: upperRimLiney2,
// increamentSize: 40);
// if(face.headEulerAngleZ!=null){
// if(face.headEulerAngleZ!>15 || face.headEulerAngleZ!<(-15) || face.headEulerAngleX!>15 || face.headEulerAngleX!<(-15) || face.headEulerAngleY!>15 || face.headEulerAngleY!<(-15)){
// print('zsssssss ${MyGlobalKeys.detectedImageViewStateKey.currentState}');
// // MyGlobalKeys.homePageStateKey.currentState?.showErrorMessage();
// }
// }
//
// double nosex1 = nose!.points[1].x.toDouble();
// double nosey1 = nose!.points[1].y.toDouble();
// var tangentAndConstant = CustomStraightLineLogics.getTangentAndConstantBetweenTwoPoints(CustomPoint(x: upperRimLinex1, y: upperRimLiney1), CustomPoint(x: upperRimLinex2, y: upperRimLiney2));
// // y = mx + c;
// double c = nosey1 - (nosex1*tangentAndConstant.tangent);
//
// drawSideFaceLineWithTangentAndConstant(
// x1: nosex1,
// y1: nosey1,
// constant: c,
// increamentSize: 20,
// tangent: tangentAndConstant.tangent
//
// );
// drawSideFaceLineWithTangentAndConstant({
//   required double x1,
//   required double y1,
//   required double tangent,
//   required double constant,
//   required double increamentSize,
// }) {
//   print('all the points are drawSideFaceLineWithTangentAndConstant(${x1}, ${y1}) and (${tangent},and  ${constant})');
//
//   double m = tangent;
//   double c = constant;
//
//   double x = x1 - increamentSize;
//   double y = (m * x) + c;
//
//   double x3 = x1 + increamentSize*6;
//   double y3 = (m * x3) + c;
//
//
//   print('drawing line on ($x,$y) and ($x3,$y3)');
//   canvas.drawLine(
//     Offset(
//       translateX(x, rotation, size, absoluteImageSize),
//       translateY(y, rotation, size, absoluteImageSize),
//     ),
//     Offset(
//       translateX(x3, rotation, size, absoluteImageSize),
//       translateY(y3, rotation, size, absoluteImageSize),
//     ),
//     paint..color = MyColors.lightBlueColor,
//   );
// }