


import 'package:dartz/dartz.dart';
import 'package:quizu/core/error/exceptions.dart';
import 'package:quizu/core/error/faliure.dart';
import 'package:quizu/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:quizu/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:quizu/features/auth/domain/entities/post_new_user_name.dart';
import 'package:quizu/features/auth/domain/entities/user.dart';
import 'package:quizu/features/auth/domain/repository/base_auth_repository.dart';
import 'package:quizu/features/auth/domain/usecases/get_token_verification_usecase.dart';
import 'package:quizu/features/auth/domain/usecases/post_login_usecase.dart';
import 'package:quizu/features/auth/domain/usecases/post_new_user_name_usecase.dart';
import 'package:quizu/features/auth/domain/usecases/set_user_data_locally_state.dart';

class AuthRepository extends BaseAuthRepository {
  BaseAuthRemoteDataSource baseMovieRemoteDataSource;
  AuthLocalDataSource authLocalDataSource;


  AuthRepository({required this.baseMovieRemoteDataSource,required this.authLocalDataSource});





  @override
  Future<Either<Failure, UserData>> postLogin(LoginParameters parameters) async {
    try {
      final result = await baseMovieRemoteDataSource.postLogin(parameters);
      // authLocalDataSource.setUserInfo(userData: result);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, PostNewUserName>> postNewUserName(
      NewUserNameParameters parameters) async {

    try {
      final result = await baseMovieRemoteDataSource.postNewUserName(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> getTokenVerification() async {

    try {
      final result =
      await baseMovieRemoteDataSource.getTokenVerification();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMassageModel.statusMessage));
    }
  }



  @override
  Future<Either<String, UserData>> getUserDataFromLocalStorage() async{
      final result = await authLocalDataSource.getUserInfo();
      return result.fold((empty) => Left(empty), (user) => Right(user));
  }

  @override
  Future<Either<Failure, bool>> setUserDataLocally(UserDataLocallyParameters parameters) async{
    try {
      final result = await authLocalDataSource.setUserInfo(parameters);
      return Right(result);
    } on LocalException catch (failure) {
      return Left(DatabaseFailure(failure.errorMassageModel.statusMessage));
    }
  }





}
