import 'package:flutter/material.dart';

class Board {
  final int id;
  final String location;
  final DateTime start_time;
  final DateTime end_time;
  final String memo;
  final String status;
  final DateTime created_at;
  final DateTime updated_at;
  final int member_id;

  Board({
    @required this.id,
    @required this.location,
    @required this.start_time,
    @required this.end_time,
    @required this.memo,
    @required this.status,
    @required this.created_at,
    @required this.updated_at,
    @required this.member_id,
  });
}
