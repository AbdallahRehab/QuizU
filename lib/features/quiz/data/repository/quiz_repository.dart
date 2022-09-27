import 'package:dartz/dartz.dart';
import 'package:quizu/core/error/exceptions.dart';
import 'package:quizu/core/error/faliure.dart';
import 'package:quizu/features/quiz/data/datasource/quiz_local_data_source.dart';
import 'package:quizu/features/quiz/data/datasource/quiz_remote_data_source.dart';
import 'package:quizu/features/quiz/domain/entities/questions.dart';
import 'package:quizu/features/quiz/domain/entities/user_info.dart';
import 'package:quizu/features/quiz/domain/repository/base_quiz_repository.dart';
import 'package:quizu/features/quiz/domain/usecases/post_score_usecase.dart';
import 'package:quizu/features/quiz/domain/usecases/set_score_data_locally_state.dart';

class QuizRepository extends BaseQuizRepository {
  BaseQuizRemoteDataSource baseQuizRemoteDataSource;
  QuizLocalDataSource quizLocalDataSource;

  QuizRepository(
      {required this.baseQuizRemoteDataSource,
      required this.quizLocalDataSource});

  @override
  Future<Either<Failure, List<Questions>>> getQuestions() async{
    try {
      final result = await baseQuizRemoteDataSource.getQuestions();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, UserInfo>> getUserInfo() async {
    try {
      final result = await baseQuizRemoteDataSource.getUserInfo();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> postScore(ScoreParameters parameters) async {
    try {
      final result = await baseQuizRemoteDataSource.postScore(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> setScoreDataLocally(ScoreDataLocallyParameters parameters) async {
    try {
      final result = await quizLocalDataSource.setScoreData(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getScoreDataLocally() async {
    try {
      final result = await quizLocalDataSource.getScoreData();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMessage));
    }
  }
}
