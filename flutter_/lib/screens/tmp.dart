import 'package:flutter/material.dart';
import 'package:flutter_/screens/generate_screen.dart';

class Tmp extends StatelessWidget {
  const Tmp({super.key});

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
                      builder: (BuildContext context) => const GenerateScreen()));
                },
                child: const Text('녹음하기'))
          ],
        ),
      ),
    );
  }
}
