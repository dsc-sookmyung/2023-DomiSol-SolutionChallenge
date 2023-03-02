import 'package:flutter_/models/record.dart';

class RecordRepository {
  final List<Record> _dumyRerods = [
    Record(
      title: "녹음 1",
      location: "숙명여자대학교 명신관",
      date: "2023년 02월 28일",
      time: "9:00 ~ 10:00",
      memo: "메모 1",
    ),
    Record(
      title: "녹음 2",
      location: "숙명여자대학교 과학관",
      date: "2023년 03월 01일",
      time: "10:00 ~ 11:00",
      memo: "메모 2",
    ),
  ];

  List<Record> getRecords() {
    return _dumyRerods;
  }
}
