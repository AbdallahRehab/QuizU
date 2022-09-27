


import 'package:dartz/dartz.dart';
import 'package:quizu/core/error/exceptions.dart';
import 'package:quizu/core/error/faliure.dart';
import 'package:quizu/core/usecase/base_useCase.dart';
import 'package:quizu/features/leaderboard/data/datasource/leaderboard_remote_data_source.dart';
import 'package:quizu/features/leaderboard/domain/entities/top10.dart';
import 'package:quizu/features/leaderboard/domain/repository/base_leaderboard_repository.dart';

class LeaderboardRepository extends BaseLeaderboardRepository {
  BaseLeaderboardRemoteDataSource baseLeaderboardRemoteDataSource;


  LeaderboardRepository({required this.baseLeaderboardRemoteDataSource,});





  @override
  Future<Either<Failure, List<Top10>>> getTop10() async {
    print('GGGGGGGGGGGGGGGGGGGGGGGGGGGGGG');
    try {
      final result = await baseLeaderboardRemoteDataSource.getTop10();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMessage));
    }
  }







}
