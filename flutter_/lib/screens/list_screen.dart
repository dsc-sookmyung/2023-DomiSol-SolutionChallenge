import 'package:flutter/material.dart';
import 'package:flutter_/models/board.dart';
import 'package:flutter_/repositories/board_repository.dart';
import 'package:flutter_/screens/modify_screen.dart';
import 'package:flutter_/screens/detail_screen.dart';

class ListScreen extends StatelessWidget {
  //final List<TmpRecord> records = RecordRepository().getRecords();
  final List<Board> boards = BoardRepository().getBoards();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: boards.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color.fromRGBO(227, 227, 227, 1),
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
                        padding: const EdgeInsets.all(16),
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
                                    '${boards[index].id}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    boards[index].location,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '${boards[index].created_at}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ]))),
                Flexible(
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.all(32),
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
                                      padding: const EdgeInsets.all(20),
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
                                            padding: const EdgeInsets.all(
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
                                          const Divider(
                                              color: Color.fromRGBO(
                                                  200, 200, 200, 1),
                                              thickness: 1.0),
                                          Padding(
                                            padding: const EdgeInsets.all(
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
                              child: const Image(
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
          return const Divider();
        },
      ),
    );
  }
}
