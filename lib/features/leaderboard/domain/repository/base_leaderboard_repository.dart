import 'package:dartz/dartz.dart';
import 'package:quizu/core/usecase/base_useCase.dart';

import '../../../../core/error/faliure.dart';
import '../entities/top10.dart';

abstract class BaseLeaderboardRepository{


  Future<Either<Failure, List<Top10>>> getTop10();

}