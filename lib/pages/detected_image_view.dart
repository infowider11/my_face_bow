import 'dart:io';

import 'package:flutter/material.dart';

class DetectedImageView extends StatelessWidget {
  final CustomPaint customPaint;
  final File file;
  const DetectedImageView(
      {Key? key, required this.customPaint, required this.file})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            // fit: StackFit.expand,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width-32,
                width: MediaQuery.of(context).size.width-32,
                child: Image.file(
                  file!,
                  // fit: BoxFit.fill,
                  alignment: Alignment.topLeft,

                ),
              ),
              if (customPaint != null)
                Positioned(
                  left: 0,right: 0,top: 0,bottom: 0,
                  child: customPaint!,
                ),
              // if (customPaint != null)
              //   Align(
              //     alignment: Alignment.center,
              //     child: customPaint!,
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
