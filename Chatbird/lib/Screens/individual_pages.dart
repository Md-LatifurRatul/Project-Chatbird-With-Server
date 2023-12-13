//import 'package:chatbird/CustomUI/own_file_card.dart';
import 'dart:convert';

import 'package:chatbird/CustomUI/own_file_card.dart';
import 'package:chatbird/CustomUI/own_message_card.dart';
import 'package:chatbird/CustomUI/reply_card.dart';
import 'package:chatbird/CustomUI/reply_file_card.dart';
//import 'package:chatbird/CustomUI/reply_file_card.dart';
import 'package:chatbird/Model/chat_model.dart';
import 'package:chatbird/Model/message_model.dart';
import 'package:chatbird/Screens/camera_screen.dart';
import 'package:chatbird/Screens/camera_view.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class IndividualPage extends StatefulWidget {
  IndividualPage(
      {super.key, required this.chatModel, required this.sourcechat});

  final ChatModel chatModel;
  final ChatModel? sourcechat;
  final logger = Logger();

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();

  IO.Socket? socket;
  bool sendButton = false;

  List<MessageModel> messages = [];

  final TextEditingController _controller = TextEditingController();

  ScrollController _scrollController = ScrollController();

  ImagePicker _picker = ImagePicker();
  late XFile file;

  int popTime = 0;

  @override
  void initState() {
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void connect() {
    print("Connecting to server...");
    socket = IO.io("http://192.168.0.109:5000/", <String, dynamic>{
      "transports": ["websocket"],
      "autoconnect": false,
    });
    socket?.connect();
    socket?.emit("signin", widget.sourcechat?.id);
    socket?.onConnect((data) {
      print("Connected to server!");
      socket?.on("message", (msg) {
        print(msg);
        setMessage(
          "destination",
          msg["message"],
          msg["path"],
        );
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });

      print("Socket ID: ${socket?.id}");
    });
    socket?.onConnectError((error) {
      print("Connection error: $error");
    });
    print("Connection status: ${socket?.connected}");
  }

  void sendMessage(String message, int sourceId, int targetId, String path) {
    setMessage("source", message, path);

    socket?.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
      "path": path
    });
  }

  void setMessage(String type, String message, String path) {
    MessageModel messageModel = MessageModel(
        message: message,
        path: path,
        type: type,
        time: DateTime.now().toString().substring(10, 16));
    print(messages);

    setState(() {
      messages.add(messageModel);
    });
  }

  void onImageSend(String path, String message) async {
    print("hey there working $message");
    for (int i = 0; i < popTime; i++) {
      Navigator.pop(context);
    }
    setState(() {
      popTime = 0;
    });

    var request = http.MultipartRequest(
        "POST", Uri.parse("http://192.168.0.109:5000/routes/addimage"));
    request.files.add(await http.MultipartFile.fromPath("img", path));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });
    http.StreamedResponse response = await request.send();

    var httpResponse = await http.Response.fromStream(response);
    var data = json.decode(httpResponse.body);
    print(data['path']);

    setMessage("source", message, path);

    socket?.emit("message", {
      "message": message,
      "sourceId": widget.sourcechat?.id,
      "targetId": widget.chatModel.id,
      "path": data['path'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/whatsAppChatImage.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                      child: SvgPicture.asset(
                        widget.chatModel.isGroup
                            ? "assets/groups.svg"
                            : "assets/person.svg",
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        height: 36,
                        width: 36,
                      ),
                    ),
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatModel.name,
                        style: const TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "last seen today at 12:05",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
                IconButton(icon: const Icon(Icons.call), onPressed: () {}),
                PopupMenuButton<String>(
                  padding: const EdgeInsets.all(0),
                  onSelected: (value) {
                    widget.logger.d(value);
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: "View Contact",
                        child: Text("View Contact"),
                      ),
                      const PopupMenuItem(
                        value: "Media, links, and docs",
                        child: Text("Media, links, and docs"),
                      ),
                      const PopupMenuItem(
                        value: "Whatsapp web",
                        child: Text("Whatsapp web"),
                      ),
                      const PopupMenuItem(
                        value: "Search",
                        child: Text("Search"),
                      ),
                      const PopupMenuItem(
                        value: "Mute Notification",
                        child: Text("Mute Notification"),
                      ),
                      const PopupMenuItem(
                        value: "wallpaper",
                        child: Text("wallpaper"),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SizedBox(
                  // height: MediaQuery.of(context).size.height - 150,
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemCount: messages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == messages.length) {
                        return Container(
                          height: 70,
                        );
                      }

                      if (messages[index].type == "source") {
                        //messages[index].path != null &&messages[index].path.isNotEmpty

                        if (messages[index].path.length > 0) {
                          return OwnFileCard(
                            path: messages[index].path,
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        } else {
                          return OwnMessageCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                      } else {
                        if (messages[index].path.length > 0) {
                          return ReplyFileCard(
                            path: messages[index].path,
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        } else
                          return ReplyCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                      }
                    },
                  ),
                ),
              ),
              _buildBottomBar(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        border: Border(
          top: BorderSide(color: Colors.grey),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: TextFormField(
                        controller: _controller,
                        focusNode: focusNode,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        onChanged: (value) {
                          if (value.length > 0) {
                            setState(() {
                              sendButton = true;
                            });
                          } else {
                            setState(() {
                              sendButton = false;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Type a message",
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.emoji_emotions),
                            onPressed: () {
                              focusNode.unfocus();
                              focusNode.canRequestFocus = false;
                              setState(() {
                                show = !show;
                              });
                            },
                          ),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.attach_file),
                                onPressed: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (builder) => bottomsheet(),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.camera_alt),
                                onPressed: () {
                                  setState(() {
                                    popTime = 2;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) => CemeraScreen(
                                        onImageSend: onImageSend,
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                          contentPadding: const EdgeInsets.all(5),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, right: 5, left: 2),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xFF128C7E),
                    child: IconButton(
                      icon: Icon(
                        sendButton ? Icons.send : Icons.mic,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (sendButton) {
                          _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut);
                          sendMessage(
                              _controller.text,
                              widget.sourcechat?.id ?? 0,
                              widget.chatModel.id ?? 0,
                              "");
                          _controller.clear();
                          setState(() {
                            sendButton = false;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            if (show) emojiSelect(),
          ],
        ),
      ),
    );
  }

  Widget bottomsheet() {
    return SizedBox(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconcreation(Icons.insert_drive_file, Colors.indigo,
                      "Document", () {}),
                  const SizedBox(
                    width: 40,
                  ),
                  iconcreation(
                    Icons.camera_alt,
                    Colors.pink,
                    "Camera",
                    () {
                      setState(() {
                        popTime = 3;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => CemeraScreen(
                            onImageSend: onImageSend,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  iconcreation(
                    Icons.insert_photo,
                    Colors.purple,
                    "Gallery",
                    () async {
                      setState(() {
                        popTime = 2;
                      });

                      file = (await _picker.pickImage(
                          source: ImageSource.gallery))!;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => CameraViewPage(
                            path: file.path,
                            onImageSend: onImageSend,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconcreation(Icons.headset, Colors.orange, "Audio", () {}),
                  const SizedBox(
                    width: 40,
                  ),
                  iconcreation(
                      Icons.location_pin, Colors.teal, "Location", () {}),
                  const SizedBox(
                    width: 40,
                  ),
                  iconcreation(Icons.person, Colors.blue, "Contact", () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconcreation(
      IconData icon, Color color, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return Container(
      // Add constraints or adjust the height as needed
      height: 200,
      child: EmojiPicker(
        config: const Config(
          columns: 7,
        ),
        onEmojiSelected: (emoji, category) {
          setState(() {
            _controller.text = _controller.text + category.emoji;
          });
        },
      ),
    );
  }
}
