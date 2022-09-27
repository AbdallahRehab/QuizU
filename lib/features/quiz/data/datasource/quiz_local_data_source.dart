import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:quizu/core/error/exceptions.dart';
import 'package:quizu/core/network/error_message_model.dart';
import 'package:quizu/core/utills/app_constance.dart';
import 'package:quizu/features/quiz/domain/usecases/set_score_data_locally_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/services_locator.dart';

abstract class QuizLocalDataSource {
  Future< List<Map<String, dynamic>>> getScoreData();

  Future<bool> setScoreData(ScoreDataLocallyParameters parameters);
}

class QuizLocalDataSourceImpl extends QuizLocalDataSource {
  List<Map<String, dynamic>> _scoreDataList = [];

  @override
  Future<List<Map<String, dynamic>>> getScoreData() async {
    final scoreDataPrefList =
        sl<SharedPreferences>().getString(AppConstance.scoreData);

    if (scoreDataPrefList != null) {
      _scoreDataList = List.from(
        (jsonDecode(scoreDataPrefList) as List).reversed.map((i) =>  i),
      );
      // _scoreDataList =_scoreDataList.sort((a, b) => DateTime.parse(a['dateTime']).compareTo(DateTime.parse(b['dateTime'])));
    }

      return _scoreDataList;
  }

  @override
  Future<bool> setScoreData(ScoreDataLocallyParameters parameters) async {
    try {
    //   sl<SharedPreferences>().clear();
      final scoreDataPrefList =
          sl<SharedPreferences>().getString(AppConstance.scoreData);


      if (scoreDataPrefList != null) {
        print('List ${scoreDataPrefList}');
        _scoreDataList = [];
        _scoreDataList = List.from(
          (jsonDecode(scoreDataPrefList) as List).map((i) =>  i),
        );

        print('qqqq ${_scoreDataList}');
      }

      Map<String, dynamic> score = _getMapFromScore(parameters: parameters);
      print('set score  ${score}');
      _scoreDataList.add(_getUserFromMap(scoreMap: score));
      print('set scossre  ${jsonEncode(_scoreDataList)}');
      await sl<SharedPreferences>()
          .setString(AppConstance.scoreData, jsonEncode(_scoreDataList));
      return true;
    } catch (e) {
      print('EEEEEEEEEEEE ${e.toString()}');
      return false;
      // throw LocalException(
      //     errorMassageModel: ErrorMassageModel(
      //         statusCode: 500, statusMessage: e.toString(), success: false));
    }
  }

  _getUserFromMap({required Map<String, dynamic> scoreMap}) {

    return {
      "score": scoreMap['score'],
      "dateTime":scoreMap['dateTime'],
    };
  }

  Map<String, dynamic> _getMapFromScore(
      {required ScoreDataLocallyParameters parameters}) {
    return {
      'score': parameters.score,
      // 'dateTime': DateFormat('dd-MM-yyyy - kk:mm:a').format(DateTime.now()),
      'dateTime': "${DateTime.now()}",
    };
  }
}
