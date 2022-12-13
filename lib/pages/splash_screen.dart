import 'package:flutter/material.dart';
import 'package:my_face_bow/constants/colors.dart';
import 'package:my_face_bow/constants/image_urls.dart';
import 'package:my_face_bow/constants/navigation_functions.dart';
import 'package:my_face_bow/pages/home_page.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  pushToHomePage()async{
    await Future.delayed(Duration(seconds: 2)).then((value){

    });
    await push(context: context, screen: HomePage());
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
    return Container(
      color: MyColors.primaryColor,
      child: Center(
        child: Image.asset(MyImages.appLogo, height: MediaQuery.of(context).size.height/2,fit: BoxFit.fitHeight,),
      ),
    );
  }
}
