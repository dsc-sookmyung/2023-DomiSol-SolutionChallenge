
import 'package:flutter/material.dart';
import 'package:flutter_/models/tmp_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'detail_screen.dart';

// ignore: must_be_immutable
class ChartPage extends StatefulWidget {
  final List<dynamic> statistic;
  

  ChartPage({super.key, required this.statistic});

  @override
  _ChartPageState createState() => _ChartPageState();
  
}

class _ChartPageState extends State<ChartPage> {
  @override

  
  Widget build(BuildContext context) {
    List<dynamic> statistic = widget.statistic;
    List<double> ratioList = statistic.map<double>((item) => item['ratio']).toList();
    final List<Chart> chartData = [Chart('차트', ratioList)];
    /*
    List<Statistic> statisticList = statistic.map((data) {
      return Statistic(
        word: data['word'],
        frequency: data['frequency'],
        ratio: data['ratio'],
      );
    }).toList();
    */

    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
          isVisible: false,
        ),
        primaryYAxis: CategoryAxis(
          isVisible: false,
        ),
        series: <ChartSeries>[
          StackedBar100Series<Chart, String>(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
              dataSource: chartData,
              xValueMapper: (Chart data, _) => data.word,
              yValueMapper: (Chart data, int index) => data.ratio[0]),
          StackedBar100Series<Chart, String>(
              dataSource: chartData,
              xValueMapper: (Chart data, _) => data.word,
              yValueMapper: (Chart data, int index) => data.ratio[1]),
          StackedBar100Series<Chart, String>(
              dataSource: chartData,
              xValueMapper: (Chart data, _) => data.word,
              yValueMapper: (Chart data, int index) => data.ratio[2]),
          StackedBar100Series<Chart, String>(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              dataSource: chartData,
              xValueMapper: (Chart data, _) => data.word,
              yValueMapper: (Chart data, _) => data.ratio[3]),
        ]);
  }
}
