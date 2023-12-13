import 'package:chatbird/Model/chat_model.dart';
import 'package:chatbird/Screens/individual_pages.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';

class Customcard extends StatefulWidget {
  const Customcard(
      {super.key, required this.chatModel, required this.sourcechat});
  final ChatModel chatModel;
  final ChatModel? sourcechat;
  @override
  State<Customcard> createState() => CustomcardState();
}

class CustomcardState extends State<Customcard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualPage(
                      chatModel: widget.chatModel,
                      sourcechat: widget.sourcechat,
                    )));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
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
            title: Text(
              widget.chatModel.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                const Icon(Icons.done_all),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  widget.chatModel.currentMessage,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            trailing: Text(widget.chatModel.time),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
