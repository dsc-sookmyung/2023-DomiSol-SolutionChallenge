import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_/widgets/login_platform.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:platform/platform.dart';
import 'package:flutter_/screens/main_page.dart';
class GoogleAuth2 extends StatefulWidget {
  @override
  _GoogleAuth2 createState() => _GoogleAuth2();
}

class _GoogleAuth2 extends State<GoogleAuth2> {

  @override
  void initState() {
    super.initState();
  }
  
  Future <void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  
    if(googleUser != null) {
    print('name = ${googleUser.displayName}');
    
    
    setState((){
      LoginPlatform _loginPlatform = LoginPlatform.google;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => MainPage(googleUser:googleUser),));

    });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          signInWithGoogle();

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