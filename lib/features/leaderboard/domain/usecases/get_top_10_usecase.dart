import 'package:dartz/dartz.dart';
import 'package:quizu/core/usecase/base_useCase.dart';

import '../../../../core/error/faliure.dart';
import '../entities/top10.dart';
import '../repository/base_leaderboard_repository.dart';

class GetTop10UseCase extends BaseUseCase<List<Top10>, NoParameters> {
  final BaseLeaderboardRepository baseLeaderboardRepository;

  GetTop10UseCase(this.baseLeaderboardRepository);

  @override
  Future<Either<Failure, List<Top10>>> call(
      NoParameters parameters) async {
    return await baseLeaderboardRepository.getTop10();
  }
}


