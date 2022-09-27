import 'package:dartz/dartz.dart';
import '../repository/base_auth_repository.dart';

import '../entities/user.dart';

class CheckUserLoginStateUseCase {
  final BaseAuthRepository authRepository;

  CheckUserLoginStateUseCase({required this.authRepository});

  Future<Either<String, UserData>> call() async {
    return await authRepository.getUserDataFromLocalStorage();
  }
}