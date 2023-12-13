//import 'package:chatbird/Model/chat_model.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class ButtonCard extends StatefulWidget {
  const ButtonCard({super.key, required this.name, required this.icon});

  final String name;
  final IconData icon;

  @override
  ContactCardState createState() => ContactCardState();
}

class ContactCardState extends State<ButtonCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 23,
        backgroundColor: const Color(0xFF25D366),
        child: Icon(
          widget.icon,
          size: 26,
          color: Colors.white,
        ),
      ),
      title: Text(
        widget.name,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
