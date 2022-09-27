part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class GetUserInfoEvent extends ProfileEvent {
  const GetUserInfoEvent();

  @override
  List<Object> get props => [];
}

class GetScoreDataEvent extends ProfileEvent {
  const GetScoreDataEvent();

  @override
  List<Object> get props => [];
}
class LogOutEvent extends ProfileEvent {
  const LogOutEvent();

  @override
  List<Object> get props => [];
}
