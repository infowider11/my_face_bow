

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
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