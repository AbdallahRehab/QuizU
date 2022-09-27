import '../../domain/entities/top10.dart';

class Top10Model extends Top10 {
  const Top10Model({
    String? name,
    int? score,
  }) : super(
          name: name,
          score: score,
        );

  factory Top10Model.fromJson(Map<String, dynamic> json) => Top10Model(
        name: json['name'] ?? "",
        score: json['score'] ?? 0,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['score'] = score;
    return data;
  }
}
