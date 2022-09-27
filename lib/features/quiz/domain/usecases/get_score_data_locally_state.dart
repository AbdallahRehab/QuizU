import 'package:dartz/dartz.dart';
import '../../../../core/error/faliure.dart';
import '../repository/base_quiz_repository.dart';


class GetScoreDataLocallyUseCase {
  final BaseQuizRepository baseQuizRepository;

  GetScoreDataLocallyUseCase({required this.baseQuizRepository});

  Future<Either<Failure, List<Map<String, dynamic>>>> call() async {
    return await baseQuizRepository.getScoreDataLocally();
  }
}