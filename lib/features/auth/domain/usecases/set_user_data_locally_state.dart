import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quizu/core/usecase/base_useCase.dart';
import 'package:quizu/features/auth/domain/entities/user.dart';
import '../repository/base_auth_repository.dart';

import '../../../../core/error/faliure.dart';

class SetUserDataLocallyStateUseCase extends BaseUseCase<bool, UserDataLocallyParameters>  {
  final BaseAuthRepository authRepository;

  SetUserDataLocallyStateUseCase({required this.authRepository});

  Future<Either<Failure, bool>> call(UserDataLocallyParameters parameters) async {
    return await authRepository.setUserDataLocally(parameters);
  }
}

class UserDataLocallyParameters extends Equatable {
  final UserData userData;

  const UserDataLocallyParameters({required this.userData});

  @override
  List<Object> get props => [userData];
}