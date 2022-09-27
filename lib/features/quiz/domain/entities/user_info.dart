import 'package:equatable/equatable.dart';


class UserInfo extends Equatable {
  final String? name;
  final String? mobile;

  const UserInfo({
    required this.name,
    required this.mobile,
  });

  @override
  List<Object?> get props => [ name, mobile];

}
