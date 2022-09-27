import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quizu/core/usecase/base_useCase.dart';
import '../repository/base_quiz_repository.dart';

import '../../../../core/error/faliure.dart';

class SetScoreDataLocallyStateUseCase extends BaseUseCase<bool, ScoreDataLocallyParameters>  {
  final BaseQuizRepository baseQuizRepository;

  SetScoreDataLocallyStateUseCase({required this.baseQuizRepository});

  Future<Either<Failure, bool>> call(ScoreDataLocallyParameters parameters) async {
    return await baseQuizRepository.setScoreDataLocally(parameters);
  }
}

class ScoreDataLocallyParameters extends Equatable {
  final String score;

  const ScoreDataLocallyParameters({required this.score});

  @override
  List<Object> get props => [score];
}