import 'package:flutter/material.dart';
import 'package:flutter_/models/board.dart';
import 'package:flutter_/models/tmp_record.dart';
import 'package:flutter_/repositories/record_repository.dart';
import 'package:flutter_/screens/record_screen.dart';

class DetailScreen extends StatelessWidget {
  final TmpRecord record = RecordRepository().getRecords().first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            child: Text(
              '${record.title} 결과',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            margin: EdgeInsets.only(bottom: 30),
          ),
          Container(
            child: Image(
              image: AssetImage('images/chick_run.png'),
              width: 50,
              height: 50,
              ),
            margin: EdgeInsets.only(bottom: 30),
          ),
          Container(
            width: 350,
            height: 170,
            margin: const EdgeInsets.all(13.0),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                    color: Color(0xff4285F4),
                    style: BorderStyle.solid,
                    width: 2)),
            //child: Text(title),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text('장소',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      )),
                    Text('${record.location}',
                    style: TextStyle(
                      fontSize: 17,
                      )),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text('날짜',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      )),
                    Text('${record.date}',
                    style: TextStyle(
                      fontSize: 17,
                      )),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text('시간',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      )),
                    Text('${record.time}',
                    style: TextStyle(
                      fontSize: 17,
                      )),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text('메모',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      )),
                    Text('${record.memo}',
                    style: TextStyle(
                      fontSize: 17,
                      )),
                  ]),
                )
              ],
            ),
          ),
          Container(
            width: 350,
            height: 400,
            margin: const EdgeInsets.all(13.0),
            padding: const EdgeInsets.only(left: 15, top: 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                    color: Color(0xff4285F4),
                    style: BorderStyle.solid,
                    width: 2)),
            //child: Text(title),
            child: Column(
              children: [
                Center(
                  child: 
                Padding(
                  padding: EdgeInsets.all(16),
                child: Text('나의 통계',
                    style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),)
                ),
              ],
            ),
          ),
        ])));
  }
}