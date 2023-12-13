import 'package:chatbird/CustomUI/custom_card.dart';
import 'package:chatbird/Model/chat_model.dart';
import 'package:chatbird/Screens/select_contact.dart';
import 'package:flutter/material.dart';

class Chatpage extends StatefulWidget {
  const Chatpage(
      {super.key, required this.chatmodels, required this.sourcechat});

  final List<ChatModel> chatmodels;
  final ChatModel? sourcechat;

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => SelectContact()));
        },
        child: const Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: widget.chatmodels.length,
        itemBuilder: (context, index) => Customcard(
          chatModel: widget.chatmodels[index],
          sourcechat: widget.sourcechat,
        ),
      ),
    );
  }
}
