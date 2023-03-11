import 'package:flutter/material.dart';

class AnalysticData {
  /* 통계 데이터 가져올 변수 클래스 */
}

class DataRepository {
  static List<double> data = [];
  static List<double> _data = [
    2.2,
    0.7,
    1.4,
    4.3,
    3.2,
    2.1,
    4.0,
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
      'MON',
      'TUE',
      'WED',
      'THU',
      'FRI',
      'SAT',
      'SUN',
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
