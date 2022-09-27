import 'package:dartz/dartz.dart';

import '../../../../core/error/faliure.dart';
import '../entities/post_new_user_name.dart';
import '../entities/user.dart';
import '../usecases/post_login_usecase.dart';
import '../usecases/post_new_user_name_usecase.dart';
import '../usecases/set_user_data_locally_state.dart';

abstract class BaseAuthRepository{


  Future<Either<Failure, UserData>> postLogin(LoginParameters parameters);
  Future<Either<Failure, PostNewUserName>> postNewUserName(NewUserNameParameters parameters);
  Future<Either<Failure, bool>> getTokenVerification();
  Future<Either<Failure, bool>> setUserDataLocally(UserDataLocallyParameters parameters);
  Future<Either<String, UserData>> getUserDataFromLocalStorage();

}