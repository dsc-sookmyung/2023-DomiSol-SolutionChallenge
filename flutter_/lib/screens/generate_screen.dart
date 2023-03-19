// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_/screens/record_screen.dart';

/*
class GenerateScreen extends StatefulWidget {
  @override
  _GenerateScreenState createState() {
    return new _GenerateScreenState();
  }

class _GenerateScreenState extends State<GenerateScreen> {

  List<Board> board = [];
  bool isLoading = true;

  @override
  void initState(){
    super.initState();
    setState(() {
      isLoading = false;
    });
  }
  */
class GenerateScreen extends StatelessWidget {
  const GenerateScreen({Key key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: const Text(
                '새로운 녹음',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SettingBox(txt: '제목'),
            const SettingBox(txt: '위치'),
            const SettingBox(txt: '메모'),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => RecordScreen()));
                },
                child: const Text('완료')),
          ]),
        ));
  }
}

class SettingBox extends StatelessWidget {
  final String txt;
  const SettingBox({Key key, @required this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: txt == '메모' ? 300 : 60,
      margin: const EdgeInsets.all(13.0),
      padding: const EdgeInsets.only(left: 15, top: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
              color: const Color(0xff4285F4), style: BorderStyle.solid, width: 2)),
      //child: Text(title),
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: 14,
        minLines: 1,
        onChanged: (value) {
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '$txt',
        ),
      ),
    );
  }
}
//}
