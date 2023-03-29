// 메인페이지(main_page.dart)에서 탭 바view 위젯

import 'package:flutter/material.dart';
import 'package:flutter_/screens/weekly_bar_chart_page.dart';
import 'package:flutter_/screens/today_bar_chart_page.dart';
import 'package:flutter_/screens/daily_bar_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

Widget tapbarView(context) {
  return Container(

    width: MediaQuery.of(context).size.width,
    height: 250,
    alignment: Alignment.center,

    child: TabBarView(physics: const BouncingScrollPhysics(), children: [
      BarChartPage1(),                                                          //weekly 차트
      BarChartPage2(),                                                          //daily 차트
      BarChartPage(),                                                           //today 차트
    ]),
  );
}

