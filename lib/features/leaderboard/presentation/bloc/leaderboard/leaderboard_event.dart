part of 'leaderboard_bloc.dart';

abstract class LeaderboardEvent extends Equatable {
  const LeaderboardEvent();

  @override
  List<Object?> get props => [];
}

class GetTop10Event extends LeaderboardEvent {


  const GetTop10Event();

  @override
  List<Object> get props => [];
}


