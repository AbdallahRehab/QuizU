import 'package:equatable/equatable.dart';


class Top10 extends Equatable {

  final String? name;
  final int? score;

  const Top10({
    required this.name,
    required this.score,
  });

  @override
  List<Object?> get props => [name, score];

}
