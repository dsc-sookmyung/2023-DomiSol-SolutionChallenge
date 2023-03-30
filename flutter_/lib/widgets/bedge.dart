// 분석 태그 뱃지 위젯

import 'package:flutter/material.dart';

Widget bedge(context) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    child: (SingleChildScrollView(
      child: Column(children: [Text('나의 언어 습관 태그'), chipList()]),
    )),
  );
}

chipList() {
  return Wrap(
    spacing: 6.0,
    runSpacing: 6.0,
    children: [
      Column(children: [
        _buildChip('욕쟁이 할머니 태그를 획득하셨습니다', Color.fromARGB(255, 247, 247, 247)),
        _buildChip('노력중! 태그를 획득하셨습니다', Color.fromARGB(255, 247, 247, 247)),
        _buildChip('천사의 말투 태그를 획득하셨습니다', Color.fromARGB(255, 247, 247, 247)),
      ])
    ],
  );
}

Widget _buildChip(String label, Color color) {
  return Chip(
    labelPadding: EdgeInsets.all(2.0),
    avatar: CircleAvatar(
      backgroundColor: Colors.white70,
      child: Text(label[0].toUpperCase()),
    ),
    label: Text(
      label,
    ),
    backgroundColor: color,
    elevation: 6.0,
    shadowColor: Colors.grey[60],
    padding: EdgeInsets.all(8.0),
  );
}
