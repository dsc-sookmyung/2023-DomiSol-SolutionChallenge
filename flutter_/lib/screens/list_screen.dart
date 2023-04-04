import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_/screens/modify_screen.dart';
import 'package:flutter_/screens/detail_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ListPage extends StatefulWidget {
  //final List<TmpRecord> records = RecordRepository().getRecords();
  //final List<Board> boards = BoardRepository().getBoards();
  const ListPage({super.key});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late List<dynamic> boards = [];

  @override
  void initState() {
    super.initState();
    _getBoards(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: boards.length,
        itemBuilder: (context, index) {
          DateTime startTime = DateTime.parse(boards[index]['startTime']); // DateTime으로 파싱
          String date = DateFormat('yyyy년 MM월 dd일').format(startTime); // DateTime으로 파싱
          String time = DateFormat('HH시 mm분').format(startTime); 
          // "yyyy년 MM월 dd일" 형식의 문자열로 변환
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color.fromRGBO(227, 227, 227, 1),
            ),
            height: 120,
            child: GestureDetector(
              onTap: () {
                debugPrint('The record $index has been tapped');
                Navigator.of(context).push(MaterialPageRoute(
                  
                    builder: (BuildContext context) => DetailPage(index: boards[index]['boardId'],)));
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
                                    '${boards[index]['title']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    boards[index]['location'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    date,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    time,
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
                                                            ModifyPage(boards[index]['boardId'])));
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
                                                _deleteBoards(context, boards[index]['boardId']);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            ListPage()));
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

  void _getBoards(BuildContext context) async {
    const storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: 'accessToken');

    Dio dio = Dio();
    dio.options.baseUrl = 'http://34.22.70.110:9090';
    dio.options.connectTimeout = const Duration(seconds: 5000);
    dio.options.receiveTimeout = const Duration(seconds: 5000);
    //print(accessToken);
    // POST 요청 보내기
    try {
      Response response = await dio.get(
        '/api/boards',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      List<dynamic> boardList = response.data['result'];

      setState(() {
        boards = boardList;
      });
    } catch (e) {
      print('GET Error $e');
    }
  }

  void _deleteBoards(BuildContext context, id) async {
    const storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: 'accessToken');

    Dio dio = Dio();
    dio.options.baseUrl = 'http://34.22.70.110:9090';
    dio.options.connectTimeout = const Duration(seconds: 5000);
    dio.options.receiveTimeout = const Duration(seconds: 5000);
    //print(accessToken);
    // POST 요청 보내기
    try {
      Response response = await dio.delete(
        '/api/boards/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
    } catch (e) {
      print('DELETE Error $e');
    }
  }
}
