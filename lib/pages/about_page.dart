import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../constants/about_us_data.dart';
import '../constants/colors.dart';



class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  bool load = false;
  String result = "";
  getData()async{
    setState(() {
      load = true;
    });
    result = aboutUsGlobalData;
    setState(() {
      load = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('About Us', style: TextStyle(color: Colors.black),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body:
      load?
      Center(child: CircularProgressIndicator(color: MyColors.lightBlueColor,)):
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Html(
            data: """$result""",
          ),
        ),
      ),
    );
  }
}
