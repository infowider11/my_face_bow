import 'package:flutter/material.dart';

import '../constants/colors.dart';

class MainHeadingText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final double? height;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  const MainHeadingText(
      this.text,
      {
    Key? key,

    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.textAlign,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color??Colors.black,
        // fontWeight:fontWeight??FontWeight.w500,
        fontSize: fontSize??20,
        // fontFamily:
        fontFamily: fontFamily,
        height: height,
      ),
    );
  }
}



class AppBarHeadingText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  const AppBarHeadingText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color??Colors.black,
          fontWeight:fontWeight??FontWeight.w500,
          fontSize: fontSize??22,
          // fontFamily:
          fontFamily: fontFamily
      ),
    );
  }
}

class SubHeadingText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign textAlign;
  final bool underlined;
  const SubHeadingText(this.text,{
    Key? key,

    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.textAlign=TextAlign.start,
    this.underlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color??Colors.black,
          fontWeight:fontWeight??FontWeight.w500,
          fontSize: fontSize??16,
          // fontFamily:
          fontFamily: fontFamily,
        decoration:underlined? TextDecoration.underline:null,
      ),
    );
  }
}



class ParagraphText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  final bool underlined;
  const ParagraphText( this.text,{
    Key? key,
    // required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.textAlign,
    this.underlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign??TextAlign.start,
      style: TextStyle(
          color: color??Colors.black,
          fontWeight:fontWeight??FontWeight.w400,
          fontSize: fontSize??14,
          // fontFamily:
          fontFamily: fontFamily,
        decoration:underlined? TextDecoration.underline:null,
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  final double thickness;
  final Color color;
   CustomDivider({Key? key, this.thickness = 1, this.color = Colors.black54}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Divider(
        indent: 0,
        endIndent: 0,
        height: thickness,
        color: color,
        thickness: thickness,
      ),
    );
  }
}
