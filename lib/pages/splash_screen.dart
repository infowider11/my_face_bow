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
