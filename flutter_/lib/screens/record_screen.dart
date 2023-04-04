import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_/screens/list_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(30),
              child: Image.network(
                  'https://i.pinimg.com/originals/ec/61/2c/ec612c4085582da4f5b8a7c2cc575bf9.gif',
                  height: 250,
                  width: 250),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              child: const Text(
                '녹음 중',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              child: ElevatedButton(
                  onPressed: () {
                    _patchTime(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => ListPage()));
                  },
                  child: const Text('녹음 완료')),
            )
          ],
        )));
  }
}

void _patchTime(BuildContext context) async {
  const storage = FlutterSecureStorage();
  final accessToken = await storage.read(key: 'accessToken');

  Dio dio = Dio();
  dio.options.baseUrl = 'http://34.22.70.110:9090';
  dio.options.connectTimeout = const Duration(seconds: 5000);
  dio.options.receiveTimeout = const Duration(seconds: 5000);
  //print(accessToken);
  // POST 요청 보내기
  try {
    await dio.patch(
      '/api/boards',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
  } catch (e) {
    print('PATCH Error $e');
  }
}
