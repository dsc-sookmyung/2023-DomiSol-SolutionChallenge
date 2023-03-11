// 주간 direction 텍스트 위젯 -> ex.이번주 욕설사용량이 증가했어요.
import 'package:flutter/material.dart';

Widget directionText(context, direction) {
  return Container(
    width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    child: Text(
      direction,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}
