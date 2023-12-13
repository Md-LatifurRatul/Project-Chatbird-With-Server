import 'package:chatbird/NewScreen/login_page.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            "Welcome to Chatbird",
            style: TextStyle(
              color: Colors.teal,
              fontSize: 29,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            "assets/bg.png",
            color: Colors.greenAccent[700],
            height: 340,
            width: 340,
            alignment: Alignment.center,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
                children: [
                  TextSpan(
                    text: "Agree and Continue to accept the",
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  TextSpan(
                    text: " Chatbird Terms of Service and Privacy Policy",
                    style: TextStyle(
                      color: Colors.cyan,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => LoginPage()),
                (route) => false,
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              elevation: 8,
              color: Colors.greenAccent[700],
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "AGREE AND CONTINUE",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
