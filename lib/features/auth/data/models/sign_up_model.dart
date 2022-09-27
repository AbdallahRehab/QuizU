

import '../../domain/entities/post_new_user_name.dart';

class PostNewUserNameModel extends PostNewUserName {
  const PostNewUserNameModel({super.name,super.mobile,});

  factory PostNewUserNameModel.fromJson(Map<String, dynamic> json) =>
       PostNewUserNameModel(
         name: json["name"],
         mobile: json["mobile"],
      );
}
