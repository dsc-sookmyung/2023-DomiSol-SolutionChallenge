import 'package:flutter/material.dart';
import 'package:flutter_/screens/record_screen.dart';

class GenerateScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              child: Text(
                '새로운 녹음',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              margin: EdgeInsets.only(bottom: 30),
            ),
            SettingBox(txt: '제목'),
            SettingBox(txt: '위치'),
            SettingBox(txt: '메모'),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => RecordScreen(
                          )));
                },
                child: Text('완료')),
          ]),
        ));
  }
}

class SettingBox extends StatelessWidget {
  final String txt;
  SettingBox({required this.txt});

  @override
  Widget build(BuildContext context) {
    String input = "";
    return Container(
        width: 350,
        height: txt == '메모' ? 300 : 60,
        margin: const EdgeInsets.all(13.0),
        padding: const EdgeInsets.only(left: 15, top: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
                color: Color(0xff4285F4), style: BorderStyle.solid, width: 2)),
        //child: Text(title),
        child: Container(
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 14,
            minLines: 1,
            onChanged: (value) {
              input = value;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '$txt',
            ),
          ),
        ));
  }
}