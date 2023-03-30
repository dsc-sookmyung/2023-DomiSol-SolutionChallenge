//today chart

import 'package:flutter/material.dart';
import '../repositories/weekly_data_repository.dart';
import 'package:chart_components/bar_chart_component.dart';

class BarChartPage1 extends StatefulWidget {
  static const String ID = 'barchartpage';

  @override
  _BarChartPageState1 createState() => _BarChartPageState1();
}

class _BarChartPageState1 extends State<BarChartPage1> {
  List<double> ratioList = [];
  List<String> wordList = [];
  bool loaded = false;


  @override
  void initState() {
    super.initState();
    //DailyDataRepository.clearData();
    ratioList = WeeklyDataRepository.getData();
    wordList = WeeklyDataRepository.getLabels();

    
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(80, 10, 10,10),
          child: Column(
            children: <Widget>[
              Expanded(
                child: BarChart(
                  data: ratioList,
                  labels: wordList,
                  labelStyle: TextStyle(fontSize: 10),
                  valueStyle:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  displayValue: true,
                  reverse: false,
                  getColor: WeeklyDataRepository.getColor,
                  barWidth: 42,
                  barSeparation: 10,
                  animationDuration: const Duration(milliseconds: 1000),
                  animationCurve: Curves.easeInOutSine,
                  itemRadius: 10,
                  //iconHeight: 24,
                  footerHeight: 24,
                  headerValueHeight: 16,
                  roundValuesOnText: false,
                  lineGridColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
