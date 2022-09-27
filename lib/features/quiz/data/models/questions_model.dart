import '../../domain/entities/questions.dart';

class QuestionsModel extends Questions {
  const QuestionsModel({
    super.Question,
    super.a,
    super.b,
    super.c,
    super.d,
    super.correct,
  });

  factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
        Question: json["Question"],
        a: json["a"],
        b: json["b"],
        c: json["c"],
        d: json["d"],
        correct: json["correct"],
      );
}
