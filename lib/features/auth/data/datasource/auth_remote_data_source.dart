import 'package:dio/dio.dart';
import 'package:quizu/core/error/exceptions.dart';
import 'package:quizu/core/network/doi_helper.dart';
import 'package:quizu/core/network/error_message_model.dart';
import 'package:quizu/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:quizu/features/auth/data/models/user_model.dart';
import 'package:quizu/features/auth/domain/usecases/post_login_usecase.dart';

import '../../domain/usecases/get_token_verification_usecase.dart';
import '../../domain/usecases/post_new_user_name_usecase.dart';
import '../models/sign_up_model.dart';

abstract class BaseAuthRemoteDataSource {
  Future<UserDataModel> postLogin(LoginParameters parameters);

  Future<PostNewUserNameModel> postNewUserName(
      NewUserNameParameters parameters);

  Future<bool> getTokenVerification();
}

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
  @override
  Future<UserDataModel> postLogin(LoginParameters parameters) async {
    try {
      final response = await DioHelper.dio.post("Login", data: {
        "OTP": parameters.OTP,
        "mobile": parameters.mobile,
      });
      if (response.statusCode == 201) {
        print(response.data);
        return UserDataModel.fromJson(response.data);
      } else {
        throw ServerException(
            errorMassageModel: ErrorMassageModel.fromJson(response.data));
      }
    } catch (e) {
      throw ServerException(
          errorMassageModel: ErrorMassageModel(
              statusCode: 500, statusMessage: e.toString(), success: false));
    }
  }

  @override
  Future<PostNewUserNameModel> postNewUserName(
      NewUserNameParameters parameters) async {
    String token = "";
    await AuthLocalDataSourceImpl().getUserInfo().then(
          (value) => value.fold((l) => token = "", (r) => token = r.token!),
    );
    final response = await DioHelper.dio.post("Name",
        options: Options(headers: {
          'Authorization':
              // "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiaWF0IjoxNjYzMzU4NDY1fQ.LlVAcArd2Bn3gtdanoHlfMOsHn0gRMqvVHozUk4bjWM",
              "Bearer $token",
        }),
        data: {
          'name': parameters.name,
        });

    if (response.statusCode == 201) {
      return PostNewUserNameModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorMassageModel: ErrorMassageModel.fromJson(response.data));
    }
  }

  @override
  Future<bool> getTokenVerification() async {

    try {
      String token = "";
      await AuthLocalDataSourceImpl().getUserInfo().then(
            (value) => value.fold((l) => token = "", (r) => token = r.token!),
      );
      final response = await DioHelper.dio.get(
        "Token",
        options: Options(headers: {
          'Authorization':
              "Bearer $token",
        }),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw ServerException(
          errorMassageModel: ErrorMassageModel(
              statusMessage: e.toString(), statusCode: 500, success: false));
    }
  }
}
