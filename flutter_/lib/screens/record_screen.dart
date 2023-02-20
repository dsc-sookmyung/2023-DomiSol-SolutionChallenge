import 'package:flutter/material.dart';
import 'package:flutter_/screens/list_screen.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

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
                child: Image.network(
                  'https://i.pinimg.com/originals/ec/61/2c/ec612c4085582da4f5b8a7c2cc575bf9.gif',
                  height: 250,
                  width: 250),
                margin: EdgeInsets.all(30),
              ),
              Container(
                child: Text('녹음 중',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                margin: EdgeInsets.all(30),
              ),
              Container(
                child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ListScreen(
                          )));
                },
                child: Text('녹음 완료')),
                margin: EdgeInsets.all(30),
              )
            ],
        )));
  }
}
