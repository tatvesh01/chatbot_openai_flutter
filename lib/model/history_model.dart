import 'dart:convert';

class HistoryModel {
  HistoryModel({
    required this.question,
    required this.answer,
    required this.time,
  });

  String question;
  String answer;
  DateTime time;


  factory HistoryModel.fromJson(Map<String, dynamic> jsonData) {
    return HistoryModel(
      question: jsonData['question'],
      answer: jsonData['answer'],
      time: DateTime.parse(jsonData['time']),
    );
  }

  static Map<String, dynamic> toMap(HistoryModel model) => {
    'question': model.question,
    'answer': model.answer,
    'time': model.time.toIso8601String(),
  };


  static String encode(List<HistoryModel> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => HistoryModel.toMap(music))
        .toList(),
  );

  static List<HistoryModel> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<HistoryModel>((item) => HistoryModel.fromJson(item))
          .toList();

}