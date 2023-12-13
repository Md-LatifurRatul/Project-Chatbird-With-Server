import 'package:chatbird/CustomUI/button_card.dart';
import 'package:chatbird/CustomUI/contact_card.dart';
import 'package:chatbird/Model/chat_model.dart';
import 'package:chatbird/Screens/create_group.dart';
import 'package:flutter/material.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  _SelectContact createState() => _SelectContact();
}

class _SelectContact extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
        appBar: AppBar(
          title: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Contact",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "256 contacts",
                style: TextStyle(
                  fontSize: 13,
                ),
              )
            ],
          ),
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.search,
                  size: 26,
                ),
                onPressed: () {}),
            PopupMenuButton<String>(
              padding: const EdgeInsets.all(0),
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: "Invite a friend",
                    child: Text("Invite a friend"),
                  ),
                  const PopupMenuItem(
                    value: "Contacts",
                    child: Text("Contacts"),
                  ),
                  const PopupMenuItem(
                    value: "Refresh",
                    child: Text("Refresh"),
                  ),
                  const PopupMenuItem(
                    value: "Help",
                    child: Text("Help"),
                  ),
                ];
              },
            ),
          ],
        ),
        body: ListView.builder(
            itemCount: contacts.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const CreateGroup()));
                  },
                  child: const ButtonCard(
                    icon: Icons.group,
                    name: "New group",
                  ),
                );
              } else if (index == 1) {
                return const ButtonCard(
                  icon: Icons.person_add,
                  name: "New contact",
                );
              }
              return ContactCard(
                contact: contacts[index - 2],
              );
            }));
  }
}
