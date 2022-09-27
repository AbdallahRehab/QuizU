part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class PostLoginEvent extends AuthEvent {
  final String OTP;
  final String mobile;

  const PostLoginEvent({required this.OTP, required this.mobile});

  @override
  List<Object> get props => [OTP, mobile];
}


class CheckUserLoginStateEvent extends AuthEvent{}

class PostNewUserEvent extends AuthEvent {
  final String name;

  const PostNewUserEvent(
      {required this.name,});

  @override
  List<Object> get props => [
        name,
      ];
}

class GetTokenVerificationEvent extends AuthEvent {


  const GetTokenVerificationEvent();

  @override
  List<Object> get props => [];
}
