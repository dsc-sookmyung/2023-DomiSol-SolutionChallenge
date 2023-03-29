import 'package:flutter_/widgets/login_auth.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSignedIn = false;

  buildHomeScreen() {
    return Text('Already Signed In');
  }

  buildSignedInScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset(
              "assets/images/pngegg_1.png",
              height: 200,
            ),
            Text(
              'Chic',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                  fontSize: 40,
                  color: Colors.blue,
                  fontFamily: 'Signatra'),                                  // 폰트정해지면 수정
            ),
            Text(
              'Check',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                  fontSize: 50,
                  color: Colors.blue,
                  fontFamily: 'Signatra'),                                 // 폰트정해지면 수정
            ),
            GoogleAuth2(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return buildHomeScreen();
    } else {
      return buildSignedInScreen();
    }
  }
}
