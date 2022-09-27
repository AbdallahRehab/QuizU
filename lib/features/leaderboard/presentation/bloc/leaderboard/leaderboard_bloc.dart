import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quizu/core/usecase/base_useCase.dart';
import 'package:quizu/core/utills/enums.dart';
import 'package:quizu/features/leaderboard/domain/entities/top10.dart';
import 'package:quizu/features/leaderboard/domain/usecases/get_top_10_usecase.dart';

part 'leaderboard_event.dart';

part 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final GetTop10UseCase getTop10UseCase;


  LeaderboardBloc({required this.getTop10UseCase})
      : super(const LeaderboardState()) {
    on<GetTop10Event>(
      _getTop10,
    );

  }



  FutureOr<void> _getTop10(
      GetTop10Event event, Emitter<LeaderboardState> emit) async {
    print('EEEEEEEEEEEE');
    final result = await getTop10UseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            top10State: RequestState.error, top10Message: l.message)),
        (r) => emit(state.copyWith(top10: r, top10State: RequestState.loaded)));


  }





}
