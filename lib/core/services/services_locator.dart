import 'package:get_it/get_it.dart';
import 'package:quizu/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:quizu/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:quizu/features/auth/data/repository/auth_repository.dart';
import 'package:quizu/features/auth/domain/repository/base_auth_repository.dart';
import 'package:quizu/features/auth/domain/usecases/check_user_login_state.dart';
import 'package:quizu/features/auth/domain/usecases/get_token_verification_usecase.dart';
import 'package:quizu/features/auth/domain/usecases/post_login_usecase.dart';
import 'package:quizu/features/auth/domain/usecases/post_new_user_name_usecase.dart';
import 'package:quizu/features/auth/domain/usecases/set_user_data_locally_state.dart';
import 'package:quizu/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:quizu/features/leaderboard/data/datasource/leaderboard_remote_data_source.dart';
import 'package:quizu/features/leaderboard/data/repository/leaderboard_repository.dart';
import 'package:quizu/features/leaderboard/domain/repository/base_leaderboard_repository.dart';
import 'package:quizu/features/leaderboard/domain/usecases/get_top_10_usecase.dart';
import 'package:quizu/features/leaderboard/presentation/bloc/leaderboard/leaderboard_bloc.dart';
import 'package:quizu/features/quiz/data/datasource/quiz_local_data_source.dart';
import 'package:quizu/features/quiz/data/datasource/quiz_remote_data_source.dart';
import 'package:quizu/features/quiz/data/repository/quiz_repository.dart';
import 'package:quizu/features/quiz/domain/repository/base_quiz_repository.dart';
import 'package:quizu/features/quiz/domain/usecases/get_questions_usecase.dart';
import 'package:quizu/features/quiz/domain/usecases/get_score_data_locally_state.dart';
import 'package:quizu/features/quiz/domain/usecases/get_user_info_usecase.dart';
import 'package:quizu/features/quiz/domain/usecases/post_score_usecase.dart';
import 'package:quizu/features/quiz/domain/usecases/set_score_data_locally_state.dart';
import 'package:quizu/features/quiz/presentation/bloc/profile/profile_bloc.dart';
import 'package:quizu/features/quiz/presentation/bloc/quiz/quiz_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() async {
    ///Bloc

    sl.registerFactory(() => AuthBloc(
        postLoginUseCase: sl(),
        postingTheNewUserNameUseCase: sl(),
        getTokenVerificationUseCase: sl(),
        checkUserLoginStateUseCase: sl(),
        setUserDataLocallyStateUseCase: sl()));
    sl.registerFactory(() => LeaderboardBloc(
          getTop10UseCase: sl(),
        ));
    sl.registerFactory(() => ProfileBloc(
        getUserInfoUseCase: sl(), getScoreDataLocallyUseCase: sl()));
    sl.registerFactory(() => QuizBloc(
        postScoreUseCase: sl(),
        setScoreDataLocallyStateUseCase: sl(),
        getQuestionsUseCase: sl()));

    /// Use cases

    sl.registerLazySingleton(() => PostLoginUseCase(sl()));
    sl.registerLazySingleton(() => PostingTheNewUserNameUseCase(sl()));
    sl.registerLazySingleton(() => GetTokenVerificationUseCase(sl()));
    sl.registerLazySingleton(
        () => CheckUserLoginStateUseCase(authRepository: sl()));
    sl.registerLazySingleton(
        () => SetUserDataLocallyStateUseCase(authRepository: sl()));
    sl.registerLazySingleton(() => GetTop10UseCase(sl()));
    sl.registerLazySingleton(() => GetUserInfoUseCase(sl()));
    sl.registerLazySingleton(() => GetQuestionsUseCase(sl()));
    sl.registerLazySingleton(
        () => GetScoreDataLocallyUseCase(baseQuizRepository: sl()));
    sl.registerLazySingleton(() => PostScoreUseCase(sl()));
    sl.registerLazySingleton(
        () => SetScoreDataLocallyStateUseCase(baseQuizRepository: sl()));

    ///Repository
    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(
        baseMovieRemoteDataSource: sl(), authLocalDataSource: sl()));
    sl.registerLazySingleton<BaseLeaderboardRepository>(
        () => LeaderboardRepository(baseLeaderboardRemoteDataSource: sl()));
    sl.registerLazySingleton<BaseQuizRepository>(() => QuizRepository(
        baseQuizRemoteDataSource: sl(), quizLocalDataSource: sl()));

    ///DATA SOURCE
    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSource());
    sl.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl());
    sl.registerLazySingleton<BaseLeaderboardRemoteDataSource>(
        () => LeaderboardRemoteDataSource());

    sl.registerLazySingleton<BaseQuizRemoteDataSource>(
        () => QuizRemoteDataSource());
    sl.registerLazySingleton<QuizLocalDataSource>(
        () => QuizLocalDataSourceImpl());

    /// External
    final sharedPreferences = await SharedPreferences.getInstance();

    sl.registerLazySingleton(() => sharedPreferences);
  }
}
