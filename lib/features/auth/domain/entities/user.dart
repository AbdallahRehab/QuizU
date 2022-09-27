import 'package:equatable/equatable.dart';


class UserData extends Equatable {
  final bool? success;
  final String? msg;
  final String? token;
  final String? name;
  final String? mobile;

  const UserData({
    required this.success,
    required this.msg,
    required this.token,
    required this.name,
    required this.mobile,
  });

  @override
  List<Object?> get props => [success, msg, token, name, mobile];

}
