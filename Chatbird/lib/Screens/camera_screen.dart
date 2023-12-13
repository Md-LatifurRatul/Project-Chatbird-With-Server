import 'dart:math';

import 'package:camera/camera.dart';
import 'package:chatbird/Screens/camera_view.dart';
import 'package:chatbird/Screens/video_view.dart';
import 'package:flutter/material.dart';
//import 'package:path/path.dart';
//import 'package:path_provider/path_provider.dart';

List<CameraDescription>? cameras;

class CemeraScreen extends StatefulWidget {
  const CemeraScreen({Key? key, required this.onImageSend}) : super(key: key);

  final Function onImageSend;

  @override
  CemeraScreenState createState() => CemeraScreenState();
}

class CemeraScreenState extends State<CemeraScreen> {
  CameraController? _cameraController;
  Future<void>? cameraValue;
  final TextEditingController _captionController = TextEditingController();
  bool isRecoring = false;
  bool flash = false;
  bool iscamerafront = true;
  double transform = 0;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras![0], ResolutionPreset.high);
    cameraValue = _cameraController?.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController?.dispose();
    _captionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: CameraPreview(_cameraController!));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          flash ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          setState(() {
                            flash = !flash;
                          });
                          flash
                              ? _cameraController?.setFlashMode(FlashMode.torch)
                              : _cameraController?.setFlashMode(FlashMode.off);
                        },
                      ),
                      GestureDetector(
                        onLongPress: () async {
                          await _cameraController!.startVideoRecording();
                          setState(() {
                            isRecoring = true;
                          });
                        },
                        onLongPressUp: () async {
                          XFile? videopath =
                              await _cameraController?.stopVideoRecording();
                          setState(() {
                            isRecoring = false;
                          });

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => VideoView(
                                        path: videopath!.path,
                                        caption: "This is a nice view",
                                      )));
                        },
                        onTap: () {
                          if (!isRecoring) takePhoto(context);
                        },
                        child: isRecoring
                            ? Icon(
                                Icons.radio_button_on,
                                color: Colors.red,
                                size: 80,
                              )
                            : Icon(
                                Icons.panorama_fish_eye,
                                color: Colors.white,
                                size: 70,
                              ),
                      ),
                      IconButton(
                        icon: Transform.rotate(
                          angle: transform,
                          child: Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            iscamerafront = !iscamerafront;
                            transform = transform + pi;
                          });
                          int cameraPos = iscamerafront ? 0 : 1;
                          _cameraController = CameraController(
                              cameras![cameraPos], ResolutionPreset.high);
                          cameraValue = _cameraController?.initialize();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Hold for Video, tap for photo",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    if (_cameraController!.value.isTakingPicture) {
      return;
    }

    try {
      await Future.delayed(Duration(seconds: 1));

      if (_cameraController!.value.isTakingPicture) {
        return;
      }

      XFile path = await _cameraController!.takePicture();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (builder) => CameraViewPage(
            path: path.path,
            onImageSend: widget.onImageSend,
            caption: _captionController.text,
          ),
        ),
      );
    } catch (e) {
      print("Error taking picture: $e");
    }
  }
}
