import 'package:chatbird/Model/chat_model.dart';
import 'package:chatbird/NewScreen/call_screen.dart';
import 'package:chatbird/Pages/Chat_page.dart';
import 'package:chatbird/Pages/camera_page.dart';
import 'package:chatbird/Pages/status_page.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Homescreen extends StatefulWidget {
  const Homescreen(
      {Key? key, required this.chatmodels, required this.sourcechat})
      : super(key: key);

  final List<ChatModel> chatmodels;
  final ChatModel? sourcechat;

  @override
  State<Homescreen> createState() => HomescreenState();
}

class HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatbird"),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(onSelected: (value) {
            logger.d(value);
          }, itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: "New group",
                child: Text("New group"),
              ),
              const PopupMenuItem(
                value: "New broadcast",
                child: Text("New broadcast"),
              ),
              const PopupMenuItem(
                value: "Chatbird wed",
                child: Text("Chatbird web"),
              ),
              const PopupMenuItem(
                value: "Starred message",
                child: Text("Starred message"),
              ),
              const PopupMenuItem(
                value: "Settings",
                child: Text("Settings"),
              ),
            ];
          })
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "CHATS",
            ),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CALLS",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          CameraPage(),
          Chatpage(
            chatmodels: widget.chatmodels,
            sourcechat: widget.sourcechat,
          ),
          StatusPage(),
          CallScreen(),
        ],
      ),
    ); // Replace with your screen's UI
  }
}
