import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/faliure.dart';
import '../../../../core/usecase/base_useCase.dart';
import '../repository/base_auth_repository.dart';

class GetTokenVerificationUseCase
    extends BaseUseCase<bool, NoParameters> {
  final BaseAuthRepository baseMovieRepository;

  GetTokenVerificationUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, bool>> call(NoParameters noParameters) async {
    return await baseMovieRepository.getTokenVerification();
  }
}


