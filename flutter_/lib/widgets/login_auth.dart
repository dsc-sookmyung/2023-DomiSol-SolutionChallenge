import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_/screens/main_page.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

class GoogleAuth extends StatefulWidget {
  @override
  _GoogleAuth createState() => _GoogleAuth();
}

class _GoogleAuth extends State<GoogleAuth> {
  @override
  void initState() {
    super.initState();
  }

  void authenticate() async {
    final url = 'http://localhost:9090/app/accounts/auth/google/login';
    final callbackUrlScheme = 'com.example.chicheck';

    try {
      final result = await FlutterWebAuth.authenticate(
          url: url, callbackUrlScheme: callbackUrlScheme);
      setState(() {
        print('sign complete');
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => MainPage(),));

      });
    } on PlatformException catch (e) {
      setState(() {
        print('$e');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          authenticate();

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
