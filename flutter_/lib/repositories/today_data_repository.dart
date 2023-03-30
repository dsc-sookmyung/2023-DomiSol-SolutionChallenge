// 하루 통계 서버 데이터
import 'package:flutter/material.dart';
import 'package:flutter_/widgets/word_analytic.dart' ;

class TodayDataRepository {
  static List<double> data = [];
  static List<double> ratioList = [];

  static List<String> wordList = [];

  static List<double> getData() {

    if (data.isEmpty) {

    daily_analytic();                                     // Call the API to get the data
  }
  return data;
  }

  static void clearData() {
    ratioList = [];
    wordList = [];                                        // ratioList와 wordList 초기화
    data = [];  
  }

  static List<String> getLabels() {
    return wordList;                                      // wordList를 label로 사용
  } 

  static Color getColor(double value) {
    if (value < 2) {
      return Color.fromARGB(255, 220, 219, 215);
    } else if (value < 4) {
      return Color.fromARGB(255, 220, 219, 215);
    } else {
      return Color.fromARGB(255, 220, 219, 215);
    }
  }

  static Color getDayColor(int day) {
    if (day < ratioList.length) {
      return getColor(ratioList[day]);
    } else {
      return Colors.indigo.shade50;
    }
  }
}