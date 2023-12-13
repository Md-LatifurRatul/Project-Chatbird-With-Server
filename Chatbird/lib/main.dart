import 'package:camera/camera.dart';
//import 'package:chatbird/NewScreen/login_page.dart';
//import 'package:chatbird/NewScreen/landing_screen.dart';
//import 'package:chatbird/NewScreen/login_page.dart';
import 'package:chatbird/Screens/camera_screen.dart';
import 'package:chatbird/Screens/login_screen.dart';
//import 'package:chatbird/Screens/home_screen.dart';
//import 'package:chatbird/Screens/login_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "OpenSans",
        primaryColor: const Color(0xFF075E54),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.red,
        ),
      ),
      home: LoginScreen(),
    );
  }
}
