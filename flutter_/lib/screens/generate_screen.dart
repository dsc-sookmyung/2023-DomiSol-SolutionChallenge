import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_/models/postBoard.dart';
import 'package:flutter_/screens/record_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GeneratePage extends StatefulWidget {
  const GeneratePage({super.key});

  @override
  _GeneratePageState createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  final storage = const FlutterSecureStorage();

  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _memoController = TextEditingController();

  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _memoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                '새로운 녹음',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildInputBox('제목', height: 60, controller: _titleController),
            const SizedBox(height: 16),
            _buildInputBox('위치', height: 60, controller: _locationController),
            const SizedBox(height: 16),
            _buildInputBox('메모', height: 100, controller: _memoController),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _postBoard(context);
              },
              child: const Text('완료'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBox(String text,
      {double? height, TextEditingController? controller}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(13, 6, 13, 6),
      padding: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff4285F4),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      height: height,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: text,
          hintText: text,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: InputBorder.none,
        ),
        maxLines: null, // Allows the text field to expand infinitely
      ),
    );
  }

  void _postBoard(BuildContext context) async {
    final accessToken = await storage.read(key: 'accessToken');

    final postBoard = PostBoard(
      title: _titleController.text,
      location: _locationController.text,
      memo: _memoController.text,
    );

    Dio dio = Dio();
    dio.options.baseUrl = 'http://34.22.70.110:9090';
    dio.options.connectTimeout = const Duration(seconds: 5000);
    dio.options.receiveTimeout = const Duration(seconds: 5000);
    //print(accessToken);
    // POST 요청 보내기
    try {
      Response response = await dio.post(
        '/api/boards',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: postBoard.toJson(),
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => RecordScreen(),
        ),
      );
    } catch (e) {
      print('POST Error $e');
    }
  }
}
