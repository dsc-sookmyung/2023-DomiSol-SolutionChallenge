// 주별 데이터 
import 'package:flutter/material.dart';


class WeeklyDataRepository {
  static List<double> data = [];
  static List<double> _data = [
    40.0,
    14.3,
    33.2,
    22.1,
    14.0,
  ];

  static List<double> getData() {
    data = _data;
    return _data;
  }

  static void clearData() {
    data = [];
  }

  static List<String> getLabels() {
    List<String> labels = [
      '1주',
      '2주',
      '3주',
      '4주',
      '5주',
    ];

    return labels;
  }

  static Color getColor(double value) {
    if (value < 2) {
      return Color.fromARGB(255, 220, 219, 215);
    } else if (value < 4) {
      return Color.fromARGB(255, 220, 219, 215);
    } else
      return Color.fromARGB(255, 220, 219, 215);
  }

  static Color getDayColor(int day) {
    if (day < data.length) {
      return getColor(data[day]);
    } else
      return Colors.indigo.shade50;
  }
}
