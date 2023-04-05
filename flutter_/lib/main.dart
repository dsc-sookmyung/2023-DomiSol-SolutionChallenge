// flutter run 
import 'package:flutter/material.dart';
import 'package:flutter_/screens/home_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chicheck',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
        accentColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}
