import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_/api/dio_setting.dart';
import 'package:flutter_/repositories/today_data_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// daily 통계 API 연결 -> 통계 데이터 가져옴

void daily_analytic() async {

  List <double> ratioList = [];
  List <String> wordList = [];
  const storage = FlutterSecureStorage();
  final accessToken = await storage.read(key: 'accessToken');

  Dio dio = createDioClient();

  try {
  Response response = await dio.get(
    '/api/boards/daily',
    options: Options(
      headers: {
        'Authorization' : 'Bearer $accessToken',
      }
    ),
  );
  
  List<dynamic> dailyResult = response.data['result'];
  for (var i =0 ; i < dailyResult.length; i++){
    ratioList.add(dailyResult[i]['ratio']);
    wordList.add(dailyResult[i]['word']);
  }
  
  TodayDataRepository.data= ratioList;
  TodayDataRepository.wordList = wordList;
  
  print(ratioList);
  print(wordList);
  
  print(accessToken);
  print(TodayDataRepository.ratioList);


} catch (e) {
  print('GET Error $e');
}
}
