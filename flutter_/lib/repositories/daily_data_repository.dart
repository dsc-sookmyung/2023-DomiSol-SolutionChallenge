import 'package:flutter/material.dart';


class DailyDataRepository {
  static List<double> data = [];
  static List<double> _data = [
    32.2,
    10.7,
    21.4,
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
