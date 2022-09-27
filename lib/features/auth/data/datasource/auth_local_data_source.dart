import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:quizu/core/error/exceptions.dart';
import 'package:quizu/core/network/error_message_model.dart';
import 'package:quizu/core/utills/app_constance.dart';
import 'package:quizu/features/auth/domain/entities/user.dart';
import 'package:quizu/features/auth/domain/usecases/set_user_data_locally_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/services_locator.dart';

abstract class AuthLocalDataSource {
  Future<Either<String, UserData>> getUserInfo();

  Future<bool> setUserInfo(UserDataLocallyParameters parameters);
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  @override
  Future<Either<String, UserData>> getUserInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userPref = sharedPreferences.getString(AppConstance.userData);

    if (userPref != null) {
      Map<String, dynamic> userMap =
          jsonDecode(userPref) as Map<String, dynamic>;
      var userObject = _getUserFromMap(userMap: userMap);
      print('User found');
      return Right(userObject);
    } else {
      return const Left('empty');
    }
  }

  @override
  Future<bool> setUserInfo(UserDataLocallyParameters parameters) async {

    try{
      Map<String, dynamic> user = _getMapFromUser(user: parameters.userData);
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences
          .setString(AppConstance.userData, jsonEncode(user));
      print('set user data');
      return true;
    }catch(e){
      throw LocalException(errorMassageModel: ErrorMassageModel(statusCode: 500,statusMessage: e.toString(), success: false));

    }
  }

  _getUserFromMap({required Map<String, dynamic> userMap}) {
    return UserData(
      success: userMap['success'],
      msg: userMap['msg'],
      token: userMap['token'],
      mobile: userMap['mobile'],
      name: userMap['name'],
    );
  }

  Map<String, dynamic> _getMapFromUser({required UserData user}) {
    return {
      'success': user.success,
      'msg': user.msg,
      'token': user.token,
      'name': user.name,
      'mobile': user.mobile,
    };
  }
}
