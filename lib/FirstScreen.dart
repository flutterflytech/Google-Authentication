import 'package:flutter/material.dart';
import 'package:google_auth_demo_flutter/LoginPage.dart';


class FirstScreen extends StatelessWidget {
  final UserData user;

  const FirstScreen({Key key, this.user}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Text(user.displayName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0
                  ),
      ),
                Text(user.email,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0
                ),)
              ],
            ),
          )),
    );
  }
}

