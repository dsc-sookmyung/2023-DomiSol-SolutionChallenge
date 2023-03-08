import 'package:flutter/material.dart';
import 'package:flutter_/models/board.dart';
import 'package:intl/intl.dart';
import 'package:flutter_/models/tmp_record.dart';

class RecordRepository {

  final List<TmpRecord> _dumyRerods = [
    TmpRecord(
      title: "녹음 1",
      location: "숙명여자대학교 명신관",
      date: DateTime.now().toString(),
      time: TimeOfDay.now().toString(),
      memo: "메모 1",
    ),
    TmpRecord(
      title: "녹음 2",
      location: "숙명여자대학교 과학관",
      date: DateTime.now().toString(),
      time: TimeOfDay.now().toString(),
      memo: "메모 2",
    ),
  ];

  List<TmpRecord> getRecords() {
    return _dumyRerods;
  }
}
