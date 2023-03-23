import 'package:flutter/material.dart';
import 'package:flutter_/models/board.dart';
import 'package:flutter_/repositories/board_repository.dart';
import 'package:flutter_/screens/floating_main_btn.dart';
import 'package:flutter_/screens/record_list.dart';

class ListScreen extends StatelessWidget {
  //final List<Board> boards = BoardRepository().getBoards();
  late List<Board> boards;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: RecordList(),
        ),
        floatingActionButton: FLoatingMainBtn(context));
  }
}
