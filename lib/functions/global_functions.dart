import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:my_face_bow/widgets/showSnackbar.dart';

void logError(String code, String? message) {
  // ignore: avoid_print
  print('Error: $code${message == null ? '' : '\nError Message: $message'}');
}

void showCameraException(CameraException e) {
  logError(e.code, e.description);
  showSnackbar('Error: ${e.code}\n${e.description}');
}

Future<File?> testCompressAndGetFile(File file, String targetPath) async {
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path, targetPath,
    quality: 40,
    rotate: 0,

  );

  print(file.lengthSync());
  print(result?.lengthSync());

  return result;
}
