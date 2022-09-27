import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quizu/core/services/services_locator.dart';
import 'package:quizu/core/utills/assets_manager.dart';
import 'package:quizu/core/utills/enums.dart';
import 'package:quizu/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:quizu/features/auth/presentation/pages/login/login_screen.dart';
import 'package:quizu/features/quiz/presentation/bloc/profile/profile_bloc.dart';
import 'package:quizu/tabs/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<ProfileBloc>()
          ..add(const GetUserInfoEvent())
          ..add(const GetScoreDataEvent()),

        child:  BlocBuilder<ProfileBloc,ProifleState>(

      builder:(context, state) =>  Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                  GestureDetector(
                    onTap: () async {
                      BlocProvider.of<ProfileBloc>(context)
                          .add(const LogOutEvent());
                      // final sharedPreferences = await SharedPreferences.getInstance();
                      // await sharedPreferences.clear();
                      // await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>   const SplashScreen(),),(route) => true,);
                      if( state.logout ==true && state.logoutState == RequestState.loaded){
                        print('LLLLLLLLLLLLLLLoooooooo');

                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>    LoginScreen(),),(route) => false,);
                                            }
                    },
                    child: const Image(
                      image: AssetImage(ImageAssets.logoutIcon),
                      fit: BoxFit.contain,
                      height: 35,
                    ),
                  ),


                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text("Profile",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<ProfileBloc, ProifleState>(
                  buildWhen: (previous, current) =>
                  previous.userInfoDataState != current.userInfoDataState,
                  builder: ((context, state) {

                    switch (state.userInfoDataState) {
                      case RequestState.loading:
                        return const SizedBox(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      case RequestState.loaded:
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text("Name: ${state.userInfoData!.name}", style: TextStyle(fontSize: 20),textAlign: TextAlign.center),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text("Mobile: ${state.userInfoData!.mobile}", style: TextStyle(fontSize: 20),textAlign: TextAlign.center),
                            ),
                          ],
                        );
                      case RequestState.error:
                        return SizedBox(
                          height: 200.0,
                          child: Center(
                            child: Text(state.userInfoDataMessage),
                          ),
                        );
                    }
                  })),

              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text("My Scores",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<ProfileBloc, ProifleState>(
                  buildWhen: (previous, current) =>
                  previous.scoreDataLocalState != current.scoreDataLocalState,
                  builder: ((context, state) {

                    switch (state.scoreDataLocalState) {
                      case RequestState.loading:
                        return const SizedBox(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      case RequestState.loaded:
                        return Expanded(
                          child: ListView.separated(

                              itemBuilder: (context, index) =>  ListTile(
                                title: Text("${DateFormat('hh:mm a  dd/MM/yyyy').format(DateTime.parse(state.scoreDataLocal[index]['dateTime']))}",
                                    style: TextStyle(fontSize: 20)),
                                trailing: Text(state.scoreDataLocal[index]['score'], style: TextStyle(fontSize: 16)),
                              ),
                              separatorBuilder: (context, index) => const SizedBox(
                                height: 8,
                              ),
                              itemCount: state.scoreDataLocal.length),
                        );
                      case RequestState.error:
                        return SizedBox(
                          height: 200.0,
                          child: Center(
                            child: Text(state.scoreDataLocalMessage),
                          ),
                        );
                    }
                  })),

            ],
          ),
        ),
      ),
    ),),);
  }
}
