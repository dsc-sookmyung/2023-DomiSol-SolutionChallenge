/*
import 'dart:convert';
import 'package:flutter_/models/board.dart';
import 'package:http/http.dart' as http;

class BoardProviders {
  Uri uri = Uri.parse("");

  Future<List<Board>> getBoard() async {
    List<Board> board = [];

    final response = await http.get(uri);

    if(response.statusCode == 200) {
      board = jsonDecode(response.body)
    }
  }
}
*/