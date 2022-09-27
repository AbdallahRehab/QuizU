import 'package:dio/dio.dart';
import 'package:quizu/core/error/exceptions.dart';
import 'package:quizu/core/network/doi_helper.dart';
import 'package:quizu/core/network/error_message_model.dart';
import 'package:quizu/core/usecase/base_useCase.dart';
import 'package:quizu/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:quizu/features/leaderboard/data/models/top10_model.dart';

abstract class BaseLeaderboardRemoteDataSource {
  Future<List<Top10Model>> getTop10();




}

class LeaderboardRemoteDataSource extends BaseLeaderboardRemoteDataSource {

  @override
  Future<List<Top10Model>> getTop10() async {
    try{
      String token ="";
      await AuthLocalDataSourceImpl().getUserInfo().then((value) =>
          value.fold((l) => token="", (r) => token=r.token!),
      );

      final response = await DioHelper.dio
          .get("TopScores",
        options: Options(
            headers: {
              'Authorization': "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiaWF0IjoxNjYzMzU4NDY1fQ.LlVAcArd2Bn3gtdanoHlfMOsHn0gRMqvVHozUk4bjWM",
            }
        ),
      );
      if (response.statusCode == 200) {
        print(response.data);
        return List<Top10Model>.from((response.data as List)
            .map((e) => Top10Model.fromJson(e)));
      } else {
        throw ServerException(errorMassageModel: ErrorMassageModel.fromJson(response.data));
      }
    }catch(e){
      throw ServerException(errorMassageModel: ErrorMassageModel(statusCode: 500,statusMessage: e.toString(), success: false));

    }
  }



}