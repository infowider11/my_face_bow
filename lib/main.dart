import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_face_bow/constants/global_keys.dart';
import 'package:my_face_bow/pages/home_page.dart';
import 'package:my_face_bow/pages/splash_screen.dart';
import 'package:my_face_bow/providers/global_provider.dart';
import 'package:provider/provider.dart';

import 'constants/global_data.dart';
import 'functions/global_functions.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }

  cameras = await availableCameras();
  runApp(ChangeNotifierProvider(
    create: (context) => GlobalProvider(),
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyFacebow',
      navigatorKey: MyGlobalKeys.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

