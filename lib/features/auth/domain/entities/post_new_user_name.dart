import 'package:equatable/equatable.dart';

class PostNewUserName extends Equatable {
  final String? name;
  final String? mobile;

  const PostNewUserName({required this.name,required this.mobile});

  @override
  List<Object?> get props => [name,mobile];
}
