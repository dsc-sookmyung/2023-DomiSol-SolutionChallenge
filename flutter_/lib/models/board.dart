import 'package:json_serializable/json_serializable.dart';

class Board {
  final BigInt id;
  final String title;
  final String location;
  final DateTime start_time;
  final DateTime end_time;
  final String memo;
  final String status;
  final BigInt member_id;

  Board({
    required this.id,
    required this.title,
    required this.location,
    required this.start_time,
    required this.end_time,
    required this.memo,
    required this.status,
    required this.member_id,
  });

  factory Board.fromJson(Map<String, dynamic> parsedJson) {
    return Board(
        id: parsedJson['id'],
        title: parsedJson['title'],
        location: parsedJson['location'],
        start_time: parsedJson['start_time'],
        end_time: parsedJson['end_time'],
        memo: parsedJson['memo'],
        status: parsedJson['status'],
        member_id: parsedJson['member_id']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'location': location,
        'start_time': start_time,
        'end_time': end_time,
        'memo': memo,
        'status': status,
        'member_id': member_id
      };
}
