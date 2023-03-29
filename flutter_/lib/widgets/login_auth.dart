import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_/providers/board_providers.dart';
import 'package:flutter_/widgets/login_platform.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_/screens/main_page.dart';
import 'package:flutter_/api/login_controller.dart';
import 'package:flutter_/api/goolge_login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'word_analytic.dart';

class GoogleAuth2 extends StatefulWidget {
  @override
  _GoogleAuth2 createState() => _GoogleAuth2();
}

class _GoogleAuth2 extends State<GoogleAuth2> {
  LoginPlatform _loginPlatform = LoginPlatform.none;
  //GoogleSignInAccount? googleUser = null;
  LoginController loginController = LoginController();
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  void signInWithGoogle() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final String? accessToken = googleAuth.accessToken;
      if (googleUser != null) {
        
        // null check 추가
        googleLoginResponse? response =
            await loginController.googleLogin(googleUser);

        prefs.setString('accessToken', accessToken!);
        
        setState(() {
          _loginPlatform = LoginPlatform.google;
          daily_analytic();
          
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MainPage(googleUser: googleUser),
          ));
        });
      }
    } catch (e) {
      print(e);
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
