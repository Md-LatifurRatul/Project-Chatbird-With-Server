import 'package:chatbird/Screens/camera_screen.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CemeraScreen(
      onImageSend: (imagePath) {
        print("Image Path: $imagePath");
      },
    );
  }
}
