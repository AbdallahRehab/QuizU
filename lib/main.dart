import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizu/bloc_observer.dart';
import 'package:quizu/core/network/doi_helper.dart';
import 'package:quizu/core/services/services_locator.dart';
import 'package:quizu/core/utills/theme_manager.dart';
import 'package:quizu/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:quizu/features/quiz/presentation/bloc/profile/profile_bloc.dart';
import 'package:quizu/features/quiz/presentation/bloc/quiz/quiz_bloc.dart';
import 'package:quizu/tabs/splash_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  ServicesLocator().init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<AuthBloc>()),
          BlocProvider(create: (_) => sl<ProfileBloc>()),
          // BlocProvider(create: (_) => sl<QuizBloc>()),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: getApplicationTheme(),
            home:  SplashScreen(),
          );
        }));
  }
}
