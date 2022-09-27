part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final UserData? login;
  final RequestState loginState;
  final String loginMessage;

  final PostNewUserName? postNewUserName;
  final RequestState postNewUserState;
  final String postNewUserMessage;

  final bool isLogin;
  final bool isTokenVerification;
  final RequestState isTokenVerificationState;
  const AuthState({
    this.login,
    this.loginState = RequestState.loaded,
    this.loginMessage = "",
    this.postNewUserName,
    this.postNewUserState = RequestState.loaded,
    this.postNewUserMessage = "",
    this.isLogin = false,
    this.isTokenVerification = false,
    this.isTokenVerificationState = RequestState.loading,
  });

  AuthState copyWith({
    UserData? login,
    RequestState? loginState,
    String? loginMessage,
    PostNewUserName? postNewUser,
    RequestState? postNewUserState,
    String? postNewUserMessage,
    bool? isLogin,
    bool? isTokenVerification,
    RequestState? isTokenVerificationState,
  }) {
    return AuthState(
      login: login ?? this.login,
      loginState: loginState ?? this.loginState,
      loginMessage: loginMessage ?? this.loginMessage,
      postNewUserName: postNewUser ?? this.postNewUserName,
      postNewUserState: postNewUserState ?? this.postNewUserState,
      postNewUserMessage: postNewUserMessage ?? this.postNewUserMessage,
      isLogin: isLogin ?? this.isLogin,
      isTokenVerification: isTokenVerification ?? this.isTokenVerification,
      isTokenVerificationState: isTokenVerificationState ?? this.isTokenVerificationState,
    );
  }

  @override
  List<Object?> get props => [
        login,
        loginState,
        loginMessage,
        postNewUserName,
        postNewUserState,
        postNewUserMessage,
        isLogin,
        isTokenVerification,
        isTokenVerificationState,
      ];
}
