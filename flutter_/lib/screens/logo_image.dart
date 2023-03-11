// 메인페이지에서 로고 위젯
import 'package:flutter/material.dart';

Widget logoImage(context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    child: Image.asset('assets/images/pngegg_2.png', height: 80),
  );
}
