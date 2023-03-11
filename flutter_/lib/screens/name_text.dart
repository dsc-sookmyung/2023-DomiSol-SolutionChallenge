// 메인페이지에서 사용자이름 위젯
import 'package:flutter/material.dart';

Widget nameText(context, userName) {
  return Container(
    width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    child: Text(
      userName,
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
  );
}
