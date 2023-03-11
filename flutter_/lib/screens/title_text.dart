// 메인페이지에서 통계 제목 위젯

import 'package:flutter/material.dart';

Widget titleText(context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    child: Text(
      '통계',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    ),
  );
}
