import 'package:chicheck/widgets/login_auth.dart';
import 'package:flutter/material.dart';
import 'package:chicheck/screens/main_page.dart';
import 'package:chicheck/widgets/login_btn.dart';

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
          //crossAxisAlignment: CrossAxisAlignment.center,
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
                  fontFamily: 'Signatra'), // 폰트정해지면 수정
            ),
            Text(
              'Check',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                  fontSize: 50,
                  color: Colors.blue,
                  fontFamily: 'Signatra'), // 폰트정해지면 수정
            ),
            //GoogleAuth(),
            GestureDetector(
                // onTap: () => print(
                //     'Button tapped'), // 구글 회원 계정 확인되면 다음 메인 페이지로 전환 함수 구현 예정
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage())),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                          margin: EdgeInsets.only(top: 200),
                          width: 350,
                          height: 50,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.blue, width: 0.5),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                alignment: Alignment.centerLeft,
                                image:
                                    AssetImage('assets/images/google_logo.png'),
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
                ))
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
