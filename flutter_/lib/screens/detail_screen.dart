import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_/screens/chart_screen.dart';
import 'package:flutter_/screens/loading_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  final int index;

  DetailPage({super.key, required this.index});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final storage = const FlutterSecureStorage();
  bool _isLoading = true;

  late String title = '';
  late String location = '';
  late String memo = '';
  late String date = '';
  late String time = '';
  late List<dynamic> statistic = [];

  List<Color> palette = [
    Color.fromRGBO(75, 135, 185, 1),
    Color.fromRGBO(192, 108, 132, 1),
    Color.fromRGBO(246, 114, 128, 1),
    Color.fromRGBO(248, 177, 149, 1),
  ];

  @override
  void initState() {
    super.initState();
    _getVoice(context, widget.index);
  }

  @override
  Widget build(BuildContext context) {
    final int index = widget.index;

    return Scaffold(
        appBar: AppBar(),
        body: _isLoading
            ? LoadingScreen()
            : Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      child: Text(
                        '$title 결과',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('장소',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      )),
                                  Text(location,
                                      style: const TextStyle(
                                        fontSize: 17,
                                      )),
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('날짜',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      )),
                                  Text(date,
                                      style: const TextStyle(
                                        fontSize: 17,
                                      )),
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('시간',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      )),
                                  Text(time,
                                      style: const TextStyle(
                                        fontSize: 17,
                                      )),
                                ]),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      '메모',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    Text(
                                      memo,
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                          const Center(
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
                            child: ChartPage(statistic: statistic),
                          ),
                          Column(
                            children: List.generate(statistic.length, (i) {
                              return Index(
                                  color: palette[i],
                                  word: statistic[i]['word'],
                                  ratio: '${statistic[i]['ratio']}');
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ])));
  }

  void _getVoice(BuildContext context, id) async {
    final accessToken = await storage.read(key: 'accessToken');

    Dio dio = Dio();
    dio.options.baseUrl = 'http://34.22.70.110:9090';
    dio.options.connectTimeout = const Duration(seconds: 5000);
    dio.options.receiveTimeout = const Duration(seconds: 5000);
    //print(accessToken);
    // POST 요청 보내기
    try {
      Response response = await dio.get(
        '/api/boards/$id/voice',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      DateTime formmated =
          DateTime.parse(response.data['result']['startTime']); // DateTime으로 파싱

      setState(() {
        title = response.data['result']['title'];
        location = response.data['result']['location'];
        memo = response.data['result']['memo'];
        date = DateFormat('yyyy년 MM월 dd일').format(formmated);
        time = DateFormat('HH시 mm분').format(formmated);
        statistic = response.data['result']['statistic'];
        statistic.sort((a, b) => b['ratio'].compareTo(a['ratio']));
        statistic = statistic.sublist(0, 4).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('GET Error $e');
    }
  }
}

class Index extends StatelessWidget {
  String word;
  String ratio;
  Color color;

  Index(
      {super.key,
      required this.word,
      required this.ratio,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(60, 20, 50, 10),
        child: Row(
          children: [
            Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            Container(
                margin: const EdgeInsets.only(left: 10),
                height: 25,
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      word,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      '$ratio%',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                )),
          ],
        ));
  }
}
