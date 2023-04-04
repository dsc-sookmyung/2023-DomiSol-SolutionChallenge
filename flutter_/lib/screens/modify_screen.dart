import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_/models/postBoard.dart';
import 'package:flutter_/screens/list_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ModifyPage extends StatefulWidget {
  final int index;

  ModifyPage(this.index);

  @override
  _ModifyPageState createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {
  final storage = const FlutterSecureStorage();

  String? xTitle;
  String? xLocation;
  String? xMemo;

  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _memoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getVoice(context, widget.index);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _locationController.dispose();
    _memoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int index = widget.index;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                '녹음 정보 수정하기',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildInputBox('제목',
                height: 60, controller: _titleController, x: xTitle),
            const SizedBox(height: 16),
            _buildInputBox('위치',
                height: 60, controller: _locationController, x: xLocation),
            const SizedBox(height: 16),
            _buildInputBox('메모',
                height: 100, controller: _memoController, x: xMemo),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _patchBoard(context, index);
              },
              child: const Text('완료'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBox(String text,
      {double? height, TextEditingController? controller, String? x}) {
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

      setState(() {
        xTitle = response.data['result']['title'];
        xLocation = response.data['result']['location'];
        xMemo = response.data['result']['memo'];

        _titleController.text = xTitle!;
        _locationController.text = xLocation!;
        _memoController.text = xMemo!;
      });

    } catch (e) {
      print('GET Error $e');
    }
  }

  void _patchBoard(BuildContext context, id) async {
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
      Response response = await dio.patch(
        '/api/boards/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: postBoard.toJson(),
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => ListPage(),
        ),
      );
    } catch (e) {
      print('PATCH Error $e');
    }
  }
}
