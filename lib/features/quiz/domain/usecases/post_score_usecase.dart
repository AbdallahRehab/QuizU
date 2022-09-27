import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/faliure.dart';
import '../../../../core/usecase/base_useCase.dart';
import '../entities/user_info.dart';
import '../repository/base_quiz_repository.dart';

class PostScoreUseCase extends BaseUseCase<bool, ScoreParameters> {
  final BaseQuizRepository baseQuizRepository;

  PostScoreUseCase(this.baseQuizRepository);

  @override
  Future<Either<Failure, bool>> call(
      ScoreParameters parameters) async {
    return await baseQuizRepository.postScore(parameters);
  }
}

class ScoreParameters extends Equatable {
  final String Score;

  const ScoreParameters({required this.Score,});

  @override
  List<Object> get props => [Score, ];
}
