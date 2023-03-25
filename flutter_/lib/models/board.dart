import 'dart:convert';

import 'package:dio/dio.dart';

class Board {
  int boardId;
  String title;
  String location;
  DateTime startTime;
  DateTime endTime;

  Board({
    required this.boardId,
    required this.title,
    required this.location,
    required this.startTime,
    required this.endTime,
  });

  factory Board.fromJson(Map<String, dynamic> json) => Board(
        boardId: json['boardId'],
        title: json['title'],
        location: json['location'],
        startTime: DateTime.parse(json['start_time']),
        endTime: DateTime.parse(json['end_time']),
      );

  Map<String, dynamic> toJson() => {
        'boardId': boardId,
        'title': title,
        'location': location,
        'start_time': startTime!.toIso8601String(),
        'end_time': endTime!.toIso8601String(),
      };
}