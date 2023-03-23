// 사용자 메인페이지
import 'package:flutter/material.dart';
import 'package:flutter_/screens/direction_text.dart';
import 'package:flutter_/screens/floating_action_btn.dart';
import 'package:flutter_/screens/logo_image.dart';
import 'package:flutter_/widgets/bedge.dart';
import 'package:flutter_/screens/tapbarView.dart';
import 'package:flutter_/screens/name_text.dart';
import 'package:flutter_/screens/title_text.dart';
import 'package:flutter_/screens/segementedtab.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
/*
동적 데이터 변수 가져오는 부분 코드 작성 필요함 
-userName
-direction 변수에 대한 정의 작성할 부분
*/

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainpageWidget(),
    );
  }
}

class MainpageWidget extends StatefulWidget {
  @override
  _MainpageWidgetState createState() => _MainpageWidgetState();
}

class _MainpageWidgetState extends State<MainpageWidget> {
  String direction = '이번 주 욕설 사용량이 증가했어요'; // 통계 값에 따라 데이터를 전달 받을 string변수
  String userName = '안재현'; // 로그인에 따라 사용자 이름 데이터를 전달 받을 string변수

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(top: 75, child: nameText(context, userName)),
              Positioned(
                top: 108,
                child: logoImage(context),
              ),
              Positioned(
                top: 257,
                child: titleText(context),
              ),
              Positioned(
                top: 293,
                child: directionText(context, direction),
              ),
              Positioned(
                top: 350,
                child: tapbarView(context),
              ),
              Positioned(top: 570, child: segementedtab(context)),
              // bedge생성
              Positioned(top: 630, child: bedge(context)),
            ],
          ),
          // ],
        ),
        floatingActionButton: 
          FLoatingActionBtn(context),
      ),
    );
  }
}
