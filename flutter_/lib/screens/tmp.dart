import 'package:flutter/material.dart';
import 'package:flutter_/screens/generate_screen.dart';

class Tmp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => GenerateScreen()));
                },
                child: Text('녹음하기'))
          ],
        ),
      ),
    );
  }
}
