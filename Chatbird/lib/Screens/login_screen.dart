import 'package:chatbird/CustomUI/button_card.dart';
import 'package:chatbird/Model/chat_model.dart';
import 'package:chatbird/Screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ChatModel? sourceChat;

  List<ChatModel> chatmodels = [
    ChatModel(
      name: "Ratul Islam",
      isGroup: false,
      currentMessage: "Hi everyone",
      time: "4:00",
      icon: "person.svg",
      id: 1,
    ),
    ChatModel(
      name: "Mahin",
      isGroup: false,
      currentMessage: "Hi Ratul",
      time: "10:00",
      icon: "person.svg",
      id: 2,
    ),
    // ChatModel(
    //   name: "Latifur",
    //   isGroup: true,
    //   currentMessage: "Hi Everyone in this group",
    //   time: "8:00",
    //   icon: "groups.svg",
    // ),
    ChatModel(
      name: "Shakhawat",
      isGroup: false,
      currentMessage: "Hello Rtl",
      time: "9:00",
      icon: "person.svg",
      id: 3,
    ),
    // ChatModel(
    //   name: "Rahman Friends",
    //   isGroup: true,
    //   currentMessage: "Hi Buddy",
    //   time: "10:00",
    //   icon: "groups.svg",
    // ),

    ChatModel(
      name: "Badhon Islam",
      isGroup: false,
      currentMessage: "Hello Mahib",
      time: "11:00",
      icon: "person.svg",
      id: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatmodels.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            sourceChat = chatmodels.removeAt(index);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (builder) => Homescreen(
                          chatmodels: chatmodels,
                          sourcechat: sourceChat,
                        )));
          },
          child: ButtonCard(
            name: chatmodels[index].name,
            icon: Icons.person,
          ),
        ),
      ),
    );
  }
}
