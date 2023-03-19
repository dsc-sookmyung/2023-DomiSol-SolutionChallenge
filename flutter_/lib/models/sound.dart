import 'package:flutter/material.dart';

class Sound {
  final int id;
  final String url;
  final String status;
  final DateTime created_at;
  final DateTime updated_at;
  final int member_id;
  final int board_id;

  Sound({
    @required this.id,
    @required this.url,
    @required this.status,
    @required this.created_at,
    @required this.updated_at,
    @required this.member_id,
    @required this.board_id,
  });
}
