part of 'profile_bloc.dart';

class ProifleState extends Equatable {
  final UserInfo? userInfoData;
  final RequestState userInfoDataState;
  final String userInfoDataMessage;

  final List<Map<String, dynamic>> scoreDataLocal;
  final RequestState scoreDataLocalState;
  final String scoreDataLocalMessage;

  final bool? logout;
  final RequestState logoutState;
  final String logoutMessage;

  const ProifleState({
    this.userInfoData,
    this.userInfoDataState = RequestState.loading,
    this.userInfoDataMessage = "",
    this.scoreDataLocal = const [],
    this.scoreDataLocalState = RequestState.loading,
    this.scoreDataLocalMessage = "",
    this.logout = false,
    this.logoutState = RequestState.loaded,
    this.logoutMessage = "",
  });

  ProifleState copyWith({
    UserInfo? userInfoData,
    RequestState? userInfoDataState,
    String? userInfoDataMessage,
    List<Map<String, dynamic>>? scoreDataLocal,
    RequestState? scoreDataLocalState,
    String? scoreDataLocalMessage,
    bool? logout,
    RequestState? logoutState,
    String? logoutMessage,
  }) {
    return ProifleState(
      userInfoData: userInfoData ?? this.userInfoData,
      userInfoDataState: userInfoDataState ?? this.userInfoDataState,
      userInfoDataMessage: userInfoDataMessage ?? this.userInfoDataMessage,
      scoreDataLocal: scoreDataLocal ?? this.scoreDataLocal,
      scoreDataLocalState: scoreDataLocalState ?? this.scoreDataLocalState,
      scoreDataLocalMessage:
          scoreDataLocalMessage ?? this.scoreDataLocalMessage,
      logout: logout ?? this.logout,
      logoutState: logoutState ?? this.logoutState,
      logoutMessage: logoutMessage ?? this.logoutMessage,
    );
  }

  @override
  List<Object?> get props => [
        userInfoData,
        userInfoDataState,
        userInfoDataMessage,
        scoreDataLocal,
        scoreDataLocalState,
        scoreDataLocalMessage,
        logout,
        logoutState,
        logoutMessage,
      ];
}
