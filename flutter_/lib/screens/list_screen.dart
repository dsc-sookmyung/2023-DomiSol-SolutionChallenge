import 'package:flutter/material.dart';
import 'package:flutter_/models/record.dart';
import 'package:flutter_/repositories/record_repository.dart';
import 'package:flutter_/screens/detail_screen.dart';

class ListScreen extends StatelessWidget {
  final List<Record> records = RecordRepository().getRecords();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: records.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${records[index].title}'),
            subtitle: Text('${records[index].location}'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => DetailScreen(
                        record: records[index],
                      ))));
            },
            tileColor: Color.fromARGB(255, 204, 204, 204),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}