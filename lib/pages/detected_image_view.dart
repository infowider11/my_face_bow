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
    print('the height is ${MediaQuery.of(context).size.width}');
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            // fit: StackFit.expand,
            children: <Widget>[
              Image.file(
                file!,
                // fit: BoxFit.fill,
                alignment: Alignment.topLeft,
                // height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
              ),
              if (customPaint != null)
                Container(
                  // color: Colors.green.withOpacity(0.2),
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    child: customPaint!,),
              // if (customPaint != null)
              //   Align(
              //     alignment: Alignment.center,
              //     child: customPaint!,
              //   ),
            ],
          ),
        ],
      ),
    );
  }
}
