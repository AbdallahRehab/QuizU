part of 'leaderboard_bloc.dart';

class LeaderboardState extends Equatable {
  final List<Top10> top10;
  final RequestState top10State;
  final String top10Message;

  const LeaderboardState({
    this.top10 = const [],
    this.top10State = RequestState.loading,
    this.top10Message = "",
  });

  LeaderboardState copyWith({
    List<Top10>? top10,
    RequestState? top10State,
    String? top10Message,
  }) {
    return LeaderboardState(
      top10: top10 ?? this.top10,
      top10State: top10State ?? this.top10State,
      top10Message: top10Message ?? this.top10Message,
    );
  }

  @override
  List<Object?> get props => [
        top10,
        top10State,
        top10Message,
      ];
}
