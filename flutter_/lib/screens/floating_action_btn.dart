// 메인페이지 통계 탭바 위젯

import 'package:flutter/material.dart';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter_/screens/generate_screen.dart';
import 'package:flutter_/screens/list_screen.dart';

Widget FLoatingActionBtn(context) {
  return FloatingActionButton(
    onPressed: () {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
                padding: const EdgeInsets.all(20),
                height: 130, // 모달 높이 크기
                decoration: const BoxDecoration(
                  color: Colors.white, // 모달 배경색
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16), // 모달 좌상단 라운딩 처리
                    topRight: Radius.circular(16), // 모달 우상단 라운딩 처리
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(
                          8), //apply padding to all four sides
                      child: GestureDetector(
                        onTap: () {
                          debugPrint('The modify has been tapped');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  GenerateScreen()));
                        },
                        child: const Text(
                          '측정하기',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const Divider(
                        color: Color.fromRGBO(200, 200, 200, 1),
                        thickness: 1.0),
                    Padding(
                      padding: const EdgeInsets.all(
                          8), //apply padding to all four sides
                      child: GestureDetector(
                        onTap: () {
                          debugPrint('The modify has been tapped');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ListScreen()));
                        },
                        child: const Text(
                          '측정 보기',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ));
          });
      //Navigator.of(context).push(MaterialPageRoute(
      //    builder: (BuildContext context) => const GenerateScreen()));
    },
    child: Icon(Icons.add),
  );
}
