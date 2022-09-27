import '../../domain/entities/user.dart';

class UserDataModel extends UserData {
  const UserDataModel({
    bool? success,
    String? msg,
    String? token,
    String? name,
    String? mobile,
  }) : super(
          success: success,
          msg: msg,
          token: token,
          name: name,
          mobile: mobile,
        );

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        success: json['success'] ?? false,
        msg: json['msg'] ?? "",
        token: json['token'],
        name: json['name'],
        mobile: json['mobile'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['msg'] = msg;
    data['token'] = token;
    data['name'] = name;
    data['mobile'] = mobile;
    return data;
  }
}
