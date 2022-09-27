import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quizu/core/usecase/base_useCase.dart';
import 'package:quizu/core/utills/enums.dart';
import 'package:quizu/features/auth/domain/entities/post_new_user_name.dart';
import 'package:quizu/features/auth/domain/entities/user.dart';
import 'package:quizu/features/auth/domain/usecases/check_user_login_state.dart';
import 'package:quizu/features/auth/domain/usecases/get_token_verification_usecase.dart';
import 'package:quizu/features/auth/domain/usecases/post_login_usecase.dart';
import 'package:quizu/features/auth/domain/usecases/post_new_user_name_usecase.dart';
import 'package:quizu/features/auth/domain/usecases/set_user_data_locally_state.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final PostLoginUseCase postLoginUseCase;
  final PostingTheNewUserNameUseCase postingTheNewUserNameUseCase;
  final GetTokenVerificationUseCase getTokenVerificationUseCase;
  final CheckUserLoginStateUseCase checkUserLoginStateUseCase;
  final SetUserDataLocallyStateUseCase setUserDataLocallyStateUseCase;

  AuthBloc(
      {required this.postLoginUseCase,
      required this.postingTheNewUserNameUseCase,
      required this.getTokenVerificationUseCase,
      required this.checkUserLoginStateUseCase,
      required this.setUserDataLocallyStateUseCase})
      : super(const AuthState()) {
    on<PostLoginEvent>(
      _postLogin,
    );
    on<PostNewUserEvent>(
      _postNewUserName,
    );

    on<GetTokenVerificationEvent>(
      _getTokenVerification,
    );

    on<CheckUserLoginStateEvent>(_checkUserLoginState);
  }

  FutureOr<void> _checkUserLoginState(
      CheckUserLoginStateEvent event, Emitter<AuthState> emit) async {
    final result = await checkUserLoginStateUseCase();
    result.fold((l) {
      emit(state.copyWith(loginMessage: l, isLogin: false));
    }, (r) {
      emit(state.copyWith(
          login: r, loginState: RequestState.loaded, isLogin: true));
      print('ee $r');
    });
  }

  FutureOr<void> _postLogin(
      PostLoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loginState: RequestState.loading));
    final result = await postLoginUseCase(
        LoginParameters(OTP: event.OTP, mobile: event.mobile));

    result.fold(
        (l) => emit(state.copyWith(
            loginState: RequestState.error, loginMessage: l.message)),
        (r) => emit(state.copyWith(login: r, loginState: RequestState.loaded)));

    if (result.isRight()) {
      final resultSaveUserData = await setUserDataLocallyStateUseCase(
          UserDataLocallyParameters(userData: state.login!));
      print('donnnnnnnnnnnne');
    }
  }

  FutureOr<void> _postNewUserName(
      PostNewUserEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(postNewUserState:  RequestState.loading));

    final result = await postingTheNewUserNameUseCase(NewUserNameParameters(
      name: event.name,
    ));

    result.fold(
        (l) => emit(state.copyWith(
            postNewUserState: RequestState.error,
            postNewUserMessage: l.message)),
        (r) => emit(state.copyWith(
            postNewUser: r, postNewUserState: RequestState.loaded)));
  }

  FutureOr<void> _getTokenVerification(
      GetTokenVerificationEvent event, Emitter<AuthState> emit) async {
    final result = await getTokenVerificationUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(isTokenVerification: false,isTokenVerificationState: RequestState.loaded)),
        (r) => emit(state.copyWith(
              isTokenVerification: r,isTokenVerificationState: RequestState.loaded
            )));
  }
}
