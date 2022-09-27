import 'package:dartz/dartz.dart';
import 'package:quizu/features/quiz/domain/usecases/set_score_data_locally_state.dart';

import '../../../../core/error/faliure.dart';
import '../entities/questions.dart';
import '../entities/user_info.dart';
import '../usecases/post_score_usecase.dart';

abstract class BaseQuizRepository {
  Future<Either<Failure, UserInfo>> getUserInfo();

  Future<Either<Failure, List<Questions>>> getQuestions();
  Future<Either<Failure, bool>> postScore(ScoreParameters parameters);
  Future<Either<Failure, bool>> setScoreDataLocally(ScoreDataLocallyParameters parameters);
  Future<Either<Failure, List<Map<String, dynamic>>>> getScoreDataLocally();
}
