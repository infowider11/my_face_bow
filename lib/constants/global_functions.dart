
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as UI;

import 'package:flutter/services.dart';
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

Future<UI.Image> loadUiImage(Uint8List uint8list) async {

  final Completer<UI.Image> completer = Completer();
  UI.decodeImageFromList(uint8list, (UI.Image img) {
    return completer.complete(img);
  });
  return completer.future;
}


// Future<File> urlToFile(Uri url) async {
// // generate random number.
//   var rng = new Random();
// // get temporary directory of device.
//   Directory tempDir = await getTemporaryDirectory();
// // get temporary path from temporary directory.
//   String tempPath = tempDir.path;
//   print('the temp path is created for ${url.path}');
// // create a new file in temporary path with random file name.
//   File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.mp3');
// // call http.get method and pass imageUrl into it to get response.
//   http.Response response = await http.get(url);
// // write bodyBytes received in response to file.
//   await file.writeAsBytes(response.bodyBytes);
// // now return the file which is created with random name in
// // temporary directory and image bytes from response is written to // that file.
//   return file;
// }