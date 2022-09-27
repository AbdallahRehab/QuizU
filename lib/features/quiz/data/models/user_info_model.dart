import '../../domain/entities/user_info.dart';

class UserInfoDataModel extends UserInfo {
  const UserInfoDataModel({
    String? name,
    String? mobile,
  }) : super(
          name: name,
          mobile: mobile,
        );

  factory UserInfoDataModel.fromJson(Map<String, dynamic> json) =>
      UserInfoDataModel(
        name: json['name'],
        mobile: json['mobile'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['mobile'] = mobile;
    return data;
  }
}
