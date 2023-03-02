import 'package:flutter/material.dart';
import 'package:flutter_/models/record.dart';
import 'package:flutter_/repositories/record_repository.dart';
import 'package:flutter_/screens/modify_screen.dart';
import 'package:flutter_/screens/detail_screen.dart';

class ListScreen extends StatelessWidget {
  final List<Record> records = RecordRepository().getRecords();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        padding: EdgeInsets.all(10),
        itemCount: records.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color.fromRGBO(227, 227, 227, 1),
            ),
            height: 120,
            child: GestureDetector(
              onTap: () {
                debugPrint('The record has been tapped');
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => DetailScreen()));
              },
              child: Row(children: [
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${records[index].title}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    '${records[index].location}',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '${records[index].date}',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '${records[index].time}',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ]))),
                Flexible(
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                debugPrint('The image button has been tapped');
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: EdgeInsets.all(20),
                                      height: 130, // 모달 높이 크기
                                      decoration: const BoxDecoration(
                                        color: Colors.white, // 모달 배경색
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              16), // 모달 좌상단 라운딩 처리
                                          topRight: Radius.circular(
                                              16), // 모달 우상단 라운딩 처리
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(
                                                8), //apply padding to all four sides
                                            child: GestureDetector(
                                              onTap: () {
                                                debugPrint(
                                                    'The modify has been tapped');
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            ModifyScreen()));
                                              },
                                              child: const Text(
                                                '수정하기',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          Divider(
                                              color: Color.fromRGBO(
                                                  200, 200, 200, 1),
                                              thickness: 1.0),
                                          Padding(
                                            padding: EdgeInsets.all(
                                                8), //apply padding to all four sides
                                            child: GestureDetector(
                                              onTap: () {
                                                debugPrint(
                                                    'The delete has been tapped');
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                '삭제하기',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ), // 모달 내부 디자인 영역
                                    );
                                  },
                                );
                              },
                              child: Image(
                                image: AssetImage('images/plus.png'),
                                color: Colors.grey,
                                width: 20,
                                height: 20,
                              ),
                            )
                          ]),
                    ))
              ]),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}
