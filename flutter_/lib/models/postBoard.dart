import 'dart:convert';

import 'package:dio/dio.dart';

class PostBoard {
  final String title;
  final String location;
  final String memo;

  PostBoard({
    required this.title,
    required this.location,
    required this.memo,
  });

  factory PostBoard.fromJson(Map<String, dynamic> json) => PostBoard(
        title: json['title'],
        location: json['location'],
        memo: json['memo'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'location': location,
        'memo': memo,
      };
}
