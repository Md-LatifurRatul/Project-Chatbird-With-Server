//import 'package:chatbird/CustomUI/button_card.dart';
import 'package:chatbird/CustomUI/avatar_card.dart';
import 'package:chatbird/CustomUI/contact_card.dart';
import 'package:chatbird/Model/chat_model.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroup createState() => _CreateGroup();
}

class _CreateGroup extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(name: "Learning Stack", status: "A full stack developer"),
    ChatModel(name: "Muaz Islam", status: "Flutter developer"),
    ChatModel(name: "Soikot Islam", status: "App developer"),
    ChatModel(name: "Sakhawat Islam", status: "Software developer"),
    ChatModel(name: "RTL Islam", status: "A React developer"),
    ChatModel(name: "Rahim Islam", status: "Iddle Person"),
    ChatModel(name: "Mahib Islam", status: "Sleepwell"),
    ChatModel(name: "Mostafifur Rahman", status: "Learning Master"),
    ChatModel(name: "Shagor Islam", status: "Apps development"),
    ChatModel(name: "Sharif Mahmud", status: "Self Learner"),
    ChatModel(name: "Manu Islam", status: "Sharing Caring"),
  ];

  List<ChatModel> groupmember = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Group",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Add participants",
                style: TextStyle(
                  fontSize: 13,
                ),
              )
            ],
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  size: 26,
                ),
                onPressed: () {}),
          ],
        ),
        body: Stack(
          children: [
            ListView.builder(
                itemCount: contacts.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      height: groupmember.length > 0 ? 90 : 10,
                    );
                  }

                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (contacts[index - 1].select == true) {
                          groupmember.remove(contacts[index - 1]);
                          contacts[index - 1].select = false;
                        } else {
                          groupmember.add(contacts[index - 1]);
                          contacts[index - 1].select = true;
                        }
                      });
                    },
                    child: ContactCard(
                      contact: contacts[index - 1],
                    ),
                  );
                }),
            groupmember.length > 0
                ? Column(
                    children: [
                      Container(
                        height: 75,
                        color: Colors.white,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: contacts.length,
                            itemBuilder: (context, index) {
                              if (contacts[index].select == true) {
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        groupmember.remove(contacts[index]);
                                        contacts[index].select = false;
                                      });
                                    },
                                    child:
                                        AvatarCard(contact: contacts[index]));
                              } else {
                                return Container();
                              }
                            }),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                    ],
                  )
                : Container(),
          ],
        ));
  }
}
