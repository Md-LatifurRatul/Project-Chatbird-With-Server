import 'package:flutter/material.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          callCard(
            "Latifur Islam",
            Icons.call_made,
            Colors.green,
            "November 4, 18:35",
          ),
          callCard(
            "Badhon Islam",
            Icons.call_missed,
            Colors.red,
            "November 2, 16:35",
          ),
          callCard(
            "Shagor Islam",
            Icons.call_received,
            Colors.green,
            "November 1, 3:35",
          ),
          callCard(
            "Latifur Islam",
            Icons.call_made,
            Colors.green,
            "November 4, 18:35",
          ),
          callCard(
            "Badhon Islam",
            Icons.call_missed,
            Colors.red,
            "November 2, 16:35",
          ),
          callCard(
            "Shagor Islam",
            Icons.call_received,
            Colors.green,
            "November 1, 3:35",
          ),
          callCard(
            "Muaz Islam",
            Icons.call_missed,
            Colors.red,
            "September 28, 18:35",
          ),
          callCard(
            "Sakhawat Islam",
            Icons.call_received,
            Colors.green,
            "September 13, 1:35",
          ),
          callCard(
            "Mahin Islam",
            Icons.call_made,
            Colors.green,
            "November 1, 4:35",
          ),
        ],
      ),
    );
  }

  Widget callCard(
      String name, IconData iconData, Color iconColor, String time) {
    return Card(
      margin: EdgeInsets.only(bottom: 0.5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 26,
        ),
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Row(
          children: [
            Icon(
              iconData,
              color: iconColor,
              size: 20,
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              time,
              style: TextStyle(fontSize: 12.8),
            ),
          ],
        ),
        trailing: Icon(
          Icons.call,
          size: 28,
          color: Colors.teal,
        ),
      ),
    );
  }
}
