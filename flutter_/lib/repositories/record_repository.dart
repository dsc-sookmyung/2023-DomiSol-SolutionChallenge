import 'package:flutter_/models/record.dart';

class RecordRepository {
  final List<Record> _dumyRerods = [
    Record(
      title: "녹음 1",
      location: "숙명여자대학교 명신관",
      time: "시간 1",
      memo: "메모 1",
    ),
    Record(
      title: "녹음 2",
      location: "숙명여자대학교 과학관",
      time: "시간 2",
      memo: "메모 2",
    ),
  ];

  List<Record> getRecords() {
    return _dumyRerods;
  }
}
