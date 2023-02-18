import 'package:flutter/material.dart';

class RecordScreen extends StatelessWidget {
  final String title;
  final String location;
  final String memo;
  RecordScreen(
      {required this.title,
      required this.location,
      required this.memo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('제목: $title'),
            Text('위치: $location'),
            Text('메모: $memo')
          ],
        ),
      ),
    );
  }
}
