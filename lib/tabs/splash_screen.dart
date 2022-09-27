import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:quizu/core/utills/assets_manager.dart';
import 'package:quizu/core/utills/enums.dart';
import 'package:quizu/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:quizu/features/auth/presentation/pages/login/login_screen.dart';
import 'package:quizu/tabs/bottom_navigation_bar_tab_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 3), () {



  // });
  }
  @override
  void didChangeDependencies() {
    BlocProvider.of<AuthBloc>(context,listen: false)
        .add( CheckUserLoginStateEvent());
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc,AuthState>(
      listener: (context, state) {
        if(state.isLogin){
          print('llllllllllllllgoin');
          BlocProvider.of<AuthBloc>(context,listen: false)
              .add( GetTokenVerificationEvent());
          if(state.isTokenVerification && state.isTokenVerificationState == RequestState.loaded){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>   const BottomNavigationBarTabs(),),(route) => true,);
          }else if(!state.isTokenVerification && state.isTokenVerificationState == RequestState.loaded){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen(),));
          }
        }else{
          print('IIIIIIIIIIIII');
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen(),));

        }
      },
    child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(ImageAssets.clockTimeIcon),
          ],
        ),
      ),
    ),
    );
  }
}


