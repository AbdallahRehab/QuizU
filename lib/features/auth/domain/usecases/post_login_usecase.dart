import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/faliure.dart';
import '../../../../core/usecase/base_useCase.dart';
import '../entities/user.dart';
import '../repository/base_auth_repository.dart';

class PostLoginUseCase extends BaseUseCase<UserData, LoginParameters> {
  final BaseAuthRepository baseMovieRepository;

  PostLoginUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, UserData>> call(
      LoginParameters parameters) async {
    return await baseMovieRepository.postLogin(parameters);
  }
}

class LoginParameters extends Equatable {
  final String OTP;
  final String mobile;

  const LoginParameters({required this.OTP, required this.mobile});

  @override
  List<Object> get props => [OTP, mobile];
}
