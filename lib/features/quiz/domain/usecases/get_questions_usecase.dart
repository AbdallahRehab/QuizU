import 'package:dartz/dartz.dart';
import 'package:quizu/core/usecase/base_useCase.dart';
import 'package:quizu/features/quiz/domain/entities/questions.dart';
import 'package:quizu/features/quiz/domain/entities/user_info.dart';
import 'package:quizu/features/quiz/domain/repository/base_quiz_repository.dart';

import '../../../../core/error/faliure.dart';

class GetQuestionsUseCase
    extends BaseUseCase<List<Questions>, NoParameters> {
  final BaseQuizRepository baseQuizRepository;

  GetQuestionsUseCase(this.baseQuizRepository);

  @override
  Future<Either<Failure, List<Questions>>> call(NoParameters noParameters) async {
    return await baseQuizRepository.getQuestions();
  }
}


