import 'package:dartz/dartz.dart';
import 'package:quizu/core/usecase/base_useCase.dart';
import 'package:quizu/features/quiz/domain/entities/user_info.dart';
import 'package:quizu/features/quiz/domain/repository/base_quiz_repository.dart';

import '../../../../core/error/faliure.dart';

class GetUserInfoUseCase
    extends BaseUseCase<UserInfo, NoParameters> {
  final BaseQuizRepository baseQuizRepository;

  GetUserInfoUseCase(this.baseQuizRepository);

  @override
  Future<Either<Failure, UserInfo>> call(NoParameters noParameters) async {
    return await baseQuizRepository.getUserInfo();
  }
}


