import 'package:chatbird/Model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactCard extends StatefulWidget {
  const ContactCard({Key? key, required this.contact}) : super(key: key);

  final ChatModel contact;

  @override
  ContactCardState createState() => ContactCardState();
}

class ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 50,
        height: 53,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: Colors.blueGrey[200],
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
                child: SvgPicture.asset(
                  "assets/person.svg",
                  //    color: Colors.white,
                  height: 30,
                  width: 30,
                ),
              ),
            ),
            widget.contact.select
                ? Positioned(
                    bottom: 4,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: Colors.teal,
                      radius: 11,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      title: Text(
        widget.contact.name,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        widget.contact.status,
        style: TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }
}
