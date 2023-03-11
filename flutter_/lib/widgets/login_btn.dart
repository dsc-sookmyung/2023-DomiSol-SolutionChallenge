// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_/screens/main_page.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 로그인 버튼 구현
    return GestureDetector(
        onTap: () async {
          try {
            await _googleSignIn.signIn();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          } catch (error) {
            print(error);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Container(
                  margin: EdgeInsets.only(top: 200),
                  width: 350,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        alignment: Alignment.centerLeft,
                        image: AssetImage('assets/images/google_logo.png'),
                      )),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Google로 로그인',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.w200),
                    ),
                  )),
            )
          ],
        ));
  }
}
