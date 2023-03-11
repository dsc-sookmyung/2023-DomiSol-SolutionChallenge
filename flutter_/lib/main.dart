import 'package:flutter/material.dart';
import 'package:flutter_/screens/chart_screen.dart';
import 'package:flutter_/screens/detail_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      /*
      theme: ThemeData(
        primarySwatch: Color(0xff4285F4),
      ),
      */
      home: DetailScreen()
    );
  }
}