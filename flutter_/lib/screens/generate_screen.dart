import 'package:flutter/material.dart';

class GenerateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              child: Text(
                '측정 생성',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
            ),
            Column(children: <Widget>[
              SettingBox(title: '장소', height: 110, context: 'context'),
              SettingBox(title: '시간', height: 110, context: 'context'),
              SettingBox(title: '메모', height: 300, context: 'context')
            ]),
            ElevatedButton(onPressed: () {}, child: Text('완료')),
          ]),
        ));
  }
}

class SettingBox extends StatelessWidget {
  final String title;
  final double height;
  final String context;
  SettingBox(
      {required this.title, required this.height, required this.context});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        height: height,
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
                color: Color(0xff4285F4), style: BorderStyle.solid, width: 2)),
        //child: Text(title),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '$title 입력하기',
              ),
            )
          ],
        ));
  }
}
