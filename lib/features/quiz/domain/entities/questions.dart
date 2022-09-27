import 'package:equatable/equatable.dart';

class Questions extends Equatable {
  final String? Question;
  final String? a;
  final String? b;
  final String? c;
  final String? d;
  final String? correct;

  const Questions(
      {required this.Question,
      required this.a,
      required this.b,
      required this.c,
      required this.d,
      required this.correct});

  @override
  List<Object?> get props => [Question, a, b, c, d, correct];
}
