import 'package:dio/dio.dart';
import 'package:quizu/core/error/exceptions.dart';
import 'package:quizu/core/network/doi_helper.dart';
import 'package:quizu/core/network/error_message_model.dart';
import 'package:quizu/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:quizu/features/quiz/data/models/user_info_model.dart';
import 'package:quizu/features/quiz/domain/usecases/post_score_usecase.dart';

import '../models/questions_model.dart';

abstract class BaseQuizRemoteDataSource {
  Future<UserInfoDataModel> getUserInfo();

  Future<List<QuestionsModel>> getQuestions();

  Future<bool> postScore(ScoreParameters parameters);
}

class QuizRemoteDataSource extends BaseQuizRemoteDataSource {

  @override
  Future<UserInfoDataModel> getUserInfo() async {

    try {
      String token = "";
      await AuthLocalDataSourceImpl().getUserInfo().then(
            (value) => value.fold((l) => token = "", (r) => token = r.token!),
      );
      final response = await DioHelper.dio.get(
        "UserInfo",
        options: Options(headers: {
          'Authorization':
              "Bearer $token",
        }),
      );
      if (response.statusCode == 200) {
        print(response.data);
        return UserInfoDataModel.fromJson(response.data);
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
  Future<List<QuestionsModel>> getQuestions() async {
    try {
      String token = "";
      await AuthLocalDataSourceImpl().getUserInfo().then(
            (value) => value.fold((l) => token = "", (r) => token = r.token!),
          );
      final response = await DioHelper.dio.get(
        "Questions",
        options: Options(headers: {
          'Authorization':
              "Bearer $token",
        }),
      );

      if (response.statusCode == 200) {
        return List<QuestionsModel>.from(
            (response.data as List).map((e) => QuestionsModel.fromJson(e)));
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
  Future<bool> postScore(ScoreParameters parameters) async {
    String token = "";
    await AuthLocalDataSourceImpl().getUserInfo().then(
          (value) => value.fold((l) => token = "", (r) => token = r.token!),
    );
    try {
      final response = await DioHelper.dio.post("Score",
          options: Options(headers: {
            'Authorization':
                // "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiaWF0IjoxNjYzMzU4NDY1fQ.LlVAcArd2Bn3gtdanoHlfMOsHn0gRMqvVHozUk4bjWM",
                "Bearer $token",
          }),
          data: {
            'score': parameters.Score,
          });
      if (response.statusCode == 201) {
        print(response.data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw ServerException(
          errorMassageModel: ErrorMassageModel(
              statusCode: 500, statusMessage: e.toString(), success: false));
    }
  }
}
