import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_/models/board.dart';
import 'package:flutter_/models/tmp_chart.dart';
import 'package:flutter_/repositories/board_repository.dart';
import 'package:flutter_/repositories/tmp_chart_repository.dart';
import 'package:flutter_/screens/chart_screen.dart';

List<TmpChart> chartData = TmpChartRepository().getTmpChart();

class DetailScreen extends StatelessWidget {
  final Board board = BoardRepository().getBoards().first;
  List<Color> palette = const <Color>[
    Color.fromRGBO(75, 135, 185, 1),
    Color.fromRGBO(192, 108, 132, 1),
    Color.fromRGBO(246, 114, 128, 1),
    Color.fromRGBO(248, 177, 149, 1),
    Color.fromRGBO(116, 180, 155, 1),
    Color.fromRGBO(0, 168, 181, 1),
    Color.fromRGBO(73, 76, 162, 1),
    Color.fromRGBO(255, 205, 96, 1),
    Color.fromRGBO(255, 240, 219, 1),
    Color.fromRGBO(238, 238, 238, 1)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Text(
              '${board.id} 결과',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: const Image(
              image: AssetImage('images/chick_run.png'),
              width: 50,
              height: 50,
            ),
          ),
          Container(
            width: 350,
            height: 170,
            margin: const EdgeInsets.all(13.0),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                    color: const Color(0xff4285F4),
                    style: BorderStyle.solid,
                    width: 2)),
            //child: Text(title),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('장소',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        Text(board.location,
                            style: const TextStyle(
                              fontSize: 17,
                            )),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('날짜',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        Text('${board.created_at}',
                            style: const TextStyle(
                              fontSize: 17,
                            )),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('시간',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('메모',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        Text(board.memo,
                            style: const TextStyle(
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
            //padding: const EdgeInsets.only(left: 15, right: 15, top: 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                    color: const Color(0xff4285F4),
                    style: BorderStyle.solid,
                    width: 2)),
            //child: Text(title),
            child: Column(
              children: [
                Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 10),
                  child: Text('나의 통계',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
                )),
                Container(
                  height: 60,
                  child: ChartScreen(),
                ),
                Index('${chartData.first.n1}'),
                Index('${chartData.first.n2}'),
                Index('${chartData.first.n3}'),
                Index('${chartData.first.n4}'),
              ],
            ),
          ),
        ])));
  }
}

class Index extends StatelessWidget {
  final String txt;
  const Index(this.txt);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(60, 20, 50, 10),
        child: Row(
          children: [
            Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(75, 135, 185, 1),
                  shape: BoxShape.circle),
            ),
            Container(
                margin: EdgeInsets.only(left: 10),
                height: 25,
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '사과',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '${txt}%',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )),
          ],
        ));
  }
}
