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
          child: Column(
            children: [
              Stack(
                // fit: StackFit.expand,
                children: <Widget>[
                  Image.file(
                    file!,
                    // fit: BoxFit.fill,
                    alignment: Alignment.topLeft,
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
