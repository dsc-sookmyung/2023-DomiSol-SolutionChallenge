import 'package:flutter/material.dart';
import 'data_repository.dart';
import 'package:chart_components/bar_chart_component.dart';

class BarChartPage extends StatefulWidget {
  static const String ID = 'barchartpage';

  @override
  _BarChartPageState createState() => _BarChartPageState();
}

class _BarChartPageState extends State<BarChartPage> {
  List<double> data = [];
  List<String> labels = [];
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    DataRepository.clearData();
    data = DataRepository.getData();
    labels = DataRepository.getLabels();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: BarChart(
                  data: data,
                  labels: labels,
                  labelStyle: TextStyle(fontSize: 10),
                  valueStyle:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  displayValue: true,
                  reverse: false,
                  getColor: DataRepository.getColor,
                  barWidth: 42,
                  barSeparation: 7,
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
