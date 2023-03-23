// 메인페이지 통계 탭바 위젯

import 'package:flutter/material.dart';
import 'package:flutter_/screens/main_page.dart';

Widget FLoatingMainBtn(context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => MainPage()));
    },
    child: Icon(Icons.home),
  );
}
