
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_auth_demo_flutter/FirstScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();



class UserData{
  final String displayName;
  final String email;
  UserData(this.displayName,this.email);

  // factory UserData.fromJson(Map<String,dynamic> json){
  //   return UserData(
  //       displayName: json['displayName'],
  //       email: json['email']);
  // }

}

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black12,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(context)
            ],
          ),
        ),
      ),
    );
  }
}

Widget _signInButton(BuildContext context) {
  return OutlineButton(
    splashColor: Colors.grey,
    onPressed: () {
     _loginButton(context);

    },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    borderSide: BorderSide(color: Colors.grey),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.login),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Sign in with Google',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          )
        ],
      ),
    ),
  );
}

void _loginButton(BuildContext context) async{
  try{
    var res = await googleSignIn.signIn();
    Navigator.push(context, new MaterialPageRoute(
              builder: (context) => new FirstScreen(user:UserData(res.displayName,res.email))));
    print("res:: $res");

  }catch(error){
    print(error);

  }
}

Future<String> signInWithGoogle() async {

  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );



  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

    return '$user';
  }

  return null;

}

void signOutGoogle() async{
  await googleSignIn.signOut();

  print("User Signed Out");
}
