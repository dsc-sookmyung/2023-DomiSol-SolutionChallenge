import 'package:flutter/material.dart';
import '../models/record.dart';

class DetailScreen extends StatelessWidget {
  final Record record;
  DetailScreen({
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(10)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(record.title,
                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    ),
                    Text(record.location)
                  ],)
              ),
            ],
          )
        ],
      ),
    );
  }
}
