import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:quizu/core/utills/assets_manager.dart';
import 'package:quizu/core/utills/enums.dart';
import 'package:quizu/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:quizu/tabs/bottom_navigation_bar_tab_screen.dart';

class NameScreen extends StatelessWidget {
  NameScreen({Key? key}) : super(key: key);

  TextEditingController textEditingControllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.postNewUserName != null && state.postNewUserState == RequestState.loaded) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const BottomNavigationBarTabs(),
            ),
            (route) => true,
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 3),
                //QuizU ⏳
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("QuizU ",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w500)),
                    Image(
                      image: AssetImage(ImageAssets.sandClock),
                      fit: BoxFit.contain,
                      height: 35,
                    )
                  ],
                ),
                const SizedBox(height: 40),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(8),
                  child:
                      Text("What’s your name?", style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(height: 20),
                //otp
                TextFormField(
                  controller: textEditingControllerName,
                  decoration: InputDecoration(
                    hintText: "Enter Your Name",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffC4C4C4))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffC4C4C4))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffC4C4C4))),
                  ),
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  maxLines: 1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter your Name";
                    }
                  },
                ),
                Spacer(),
                SizedBox(height: 40),
                BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: ((cxt, state) {
                      switch (state.postNewUserState) {
                        case RequestState.loading:
                          return const SizedBox(
                            child: Center(child: CircularProgressIndicator()),
                          );
                        case RequestState.loaded:
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xffD9D9D9)),
                                  elevation: MaterialStateProperty.all(0),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 25)),
                                ),
                                child: const Text('Done',
                                    style: TextStyle(color: Colors.black)),
                                onPressed: () {
                                  if (textEditingControllerName
                                      .text.isNotEmpty) {
                                    //   // BlocProvider.of<AuthBloc>(context, listen: false)
                                    //   //     .add( CheckUserLoginStateEvent());
                                    BlocProvider.of<AuthBloc>(context).add(
                                        PostNewUserEvent(
                                            name: textEditingControllerName
                                                .text));
                                    //
                                    // BlocProvider.of<QuizBloc>(context,
                                    //         listen: false)
                                    //     .add(SetScoreDataEvent(Score: '11'));
                                    //
                                    //       BlocProvider.of<AuthBloc>(context, listen: false)
                                    //       .add( PostNewUserEvent(name: textEditingControllerName.text));
                                    // };
                                    // // if ( BlocProvider.of<AuthBloc>(
                                    // // context,).state.postNewUserName != null ) {
                                    //
                                    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>   const BottomNavigationBarTabs(),),(route) => true,);
                                    // // }
                                  } else {
                                    showToast(
                                      "Enter your name",
                                      context: context,
                                      animation: StyledToastAnimation.scale,
                                      reverseAnimation:
                                          StyledToastAnimation.fade,
                                      position: StyledToastPosition.bottom,
                                      animDuration: const Duration(seconds: 1),
                                      duration: const Duration(seconds: 4),
                                      curve: Curves.elasticOut,
                                      reverseCurve: Curves.linear,
                                    );
                                  }
                                },
                              ),
                            ],
                          );
                        case RequestState.error:
                          return Column(
                            children: [
                              // Builder(
                              //   builder: (BuildContext context) {
                              //     showToast(
                              //       state.postNewUserMessage,
                              //       context: context,
                              //       animation: StyledToastAnimation.scale,
                              //       reverseAnimation: StyledToastAnimation.fade,
                              //       position: StyledToastPosition.bottom,
                              //       animDuration: const Duration(seconds: 1),
                              //       duration: const Duration(seconds: 4),
                              //       curve: Curves.elasticOut,
                              //       reverseCurve: Curves.linear,
                              //     );
                              //     return SizedBox();
                              //   },
                              //
                              // ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color(0xffD9D9D9)),
                                      elevation: MaterialStateProperty.all(0),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 25)),
                                    ),
                                    child: const Text('Done',
                                        style: TextStyle(color: Colors.black)),
                                    onPressed: () {
                                      if (textEditingControllerName
                                          .text.isNotEmpty) {
                                        //   // BlocProvider.of<AuthBloc>(context, listen: false)
                                        //   //     .add( CheckUserLoginStateEvent());
                                        //   BlocProvider.of<AuthBloc>(context, listen: false)
                                        //       .add( PostNewUserEvent(name: textEditingControllerName.text));
                                        //
                                        BlocProvider.of<AuthBloc>(context).add(
                                            PostNewUserEvent(
                                                name: textEditingControllerName
                                                    .text));
                                        // if ( BlocProvider.of<AuthBloc>(
                                        // context,).state.postNewUserName != null ) {
                                        // Navigator.of(context)
                                        //     .pushAndRemoveUntil(
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         const BottomNavigationBarTabs(),
                                        //   ),
                                        //   (route) => false,
                                        // );
                                        // }
                                        //
                                        //       BlocProvider.of<AuthBloc>(context, listen: false)
                                        //       .add( PostNewUserEvent(name: textEditingControllerName.text));
                                        // };
                                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>   BottomNavigationBarTabs(),));

                                      } else {
                                        showToast(
                                          "Enter your name",
                                          context: context,
                                          animation: StyledToastAnimation.scale,
                                          reverseAnimation:
                                              StyledToastAnimation.fade,
                                          position: StyledToastPosition.bottom,
                                          animDuration:
                                              const Duration(seconds: 1),
                                          duration: const Duration(seconds: 4),
                                          curve: Curves.elasticOut,
                                          reverseCurve: Curves.linear,
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          );
                      }
                    })),

                Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
