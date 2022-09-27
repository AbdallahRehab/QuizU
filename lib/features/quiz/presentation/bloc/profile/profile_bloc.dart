import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quizu/core/services/services_locator.dart';
import 'package:quizu/core/usecase/base_useCase.dart';
import 'package:quizu/core/utills/enums.dart';
import 'package:quizu/features/quiz/domain/entities/user_info.dart';
import 'package:quizu/features/quiz/domain/usecases/get_score_data_locally_state.dart';
import 'package:quizu/features/quiz/domain/usecases/get_user_info_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProifleState> {
  final GetUserInfoUseCase getUserInfoUseCase;
  final GetScoreDataLocallyUseCase getScoreDataLocallyUseCase;

  ProfileBloc({
    required this.getUserInfoUseCase,
    required this.getScoreDataLocallyUseCase,
  }) : super(const ProifleState()) {
    on<GetUserInfoEvent>(
      _getUserInfo,
    );
    on<GetScoreDataEvent>(
      _getScoreData,
    );
    on<LogOutEvent>(
      _logOutEvent,
    );
  }

  FutureOr<void> _getUserInfo(
      GetUserInfoEvent event, Emitter<ProifleState> emit) async {
    final result = await getUserInfoUseCase(NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            userInfoDataState: RequestState.error,
            userInfoDataMessage: l.message)),
        (r) => emit(state.copyWith(
            userInfoData: r, userInfoDataState: RequestState.loaded)));
  }

  FutureOr<void> _getScoreData(
      GetScoreDataEvent event, Emitter<ProifleState> emit) async {
    final result = await getScoreDataLocallyUseCase();

    result.fold(
        (l) => emit(state.copyWith(
            scoreDataLocalState: RequestState.error,
            scoreDataLocalMessage: l.message)),
        (r) => emit(state.copyWith(
            scoreDataLocal: r, scoreDataLocalState: RequestState.loaded)));
  }

  Future<FutureOr<void>> _logOutEvent(
      LogOutEvent event, Emitter<ProifleState> emit) async {
    emit(state.copyWith(logoutState: RequestState.loading));
    try {
      // await sl<SharedPreferences>().clear();
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.clear();
      emit(state.copyWith(logout: true, logoutState: RequestState.loaded));
    } catch (e) {
      emit(state.copyWith(
          logoutState: RequestState.loaded, logoutMessage: e.toString()));
    }
  }
}
