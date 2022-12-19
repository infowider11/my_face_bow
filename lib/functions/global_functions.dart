import 'package:camera/camera.dart';
import 'package:my_face_bow/widgets/showSnackbar.dart';

void logError(String code, String? message) {
  // ignore: avoid_print
  print('Error: $code${message == null ? '' : '\nError Message: $message'}');
}

void showCameraException(CameraException e) {
  logError(e.code, e.description);
  showSnackbar('Error: ${e.code}\n${e.description}');
}