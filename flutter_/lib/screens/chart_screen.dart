import 'package:flutter/material.dart';
import 'package:flutter_/models/tmp_chart.dart';
import 'package:flutter_/repositories/tmp_chart_repository.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class ChartScreen extends StatelessWidget {
  ChartScreen({Key key});

  List<TmpChart> chartData = TmpChartRepository().getTmpChart();

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
          isVisible: false,
        ),
        primaryYAxis: CategoryAxis(
          isVisible: false,
        ),
        series: <ChartSeries>[
          StackedBar100Series<TmpChart, String>(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
              dataSource: chartData,
              xValueMapper: (TmpChart data, _) => data.name,
              yValueMapper: (TmpChart data, _) => data.n1),
          StackedBar100Series<TmpChart, String>(
              dataSource: chartData,
              xValueMapper: (TmpChart data, _) => data.name,
              yValueMapper: (TmpChart data, _) => data.n2),
          StackedBar100Series<TmpChart, String>(
              dataSource: chartData,
              xValueMapper: (TmpChart data, _) => data.name,
              yValueMapper: (TmpChart data, _) => data.n3),
          StackedBar100Series<TmpChart, String>(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              dataSource: chartData,
              xValueMapper: (TmpChart data, _) => data.name,
              yValueMapper: (TmpChart data, _) => data.n4),
        ]);
  }
}
