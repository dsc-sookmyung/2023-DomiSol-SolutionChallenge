// 사용자 메인페이지
import 'package:flutter/material.dart';
import 'package:flutter_/screens/main_page/direction_text.dart';
import 'package:flutter_/screens/main_page/logo_image.dart';
import 'package:flutter_/widgets/bedge.dart';
import 'package:flutter_/screens/main_page/tapbarView.dart';
import 'package:flutter_/screens/main_page/name_text.dart';
import 'package:flutter_/screens/main_page/title_text.dart';
import 'package:flutter_/screens/main_page/segementedtab.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_/screens/floating_action_btn.dart';


class MainPage extends StatelessWidget {

  String direction = '이번 주 욕설 사용량이 증가했어요';                                        // 통계 값에 따라 데이터를 전달 받을 string변수

  final GoogleSignInAccount googleUser;

  MainPage({
    Key? key,
    required this.googleUser,

  }) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(top: 75, child: nameText(context, googleUser.displayName)),
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
              FLoatingActionBtn(context, googleUser),
      ),
    );
  }
}