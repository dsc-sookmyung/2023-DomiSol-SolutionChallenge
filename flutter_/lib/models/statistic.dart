import 'dart:ffi';

class Statistic {
  String word;
  int frequency;
  Float ratio;

  Statistic({
    required this.word,
    required this.frequency,
    required this.ratio,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) => Statistic(
        word: json['word'],
        frequency: json['frequency'],
        ratio: json['ratio'],
      );

  Map<String, dynamic> toJson() => {
        'word': word,
        'frequency': frequency,
        'ratio': ratio,
      };
}