import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:quizu/core/utills/assets_manager.dart';
import 'package:quizu/core/utills/enums.dart';
import 'package:quizu/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:quizu/features/auth/presentation/pages/login/name_screen.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpScreen extends StatelessWidget {
  final String phoneNumber;

  OtpScreen({Key? key, required this.phoneNumber}) : super(key: key);

  String _code = "";
  String signature = "{{ app signature }}";

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.login != null&& state.loginState == RequestState.loaded) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NameScreen(),
            ));
          }
        },
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 3),
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
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Please enter the OTP sent to your mobile",
                        style: TextStyle(fontSize: 20)),
                  ),
                  const SizedBox(height: 20),
                  //otp
                  PinFieldAutoFill(
                    decoration: UnderlineDecoration(
                      textStyle:
                          const TextStyle(fontSize: 30, color: Colors.black),
                      colorBuilder:
                          FixedColorBuilder(Colors.black.withOpacity(0.3)),
                    ),
                    currentCode: _code,
                    codeLength: 4,
                    onCodeSubmitted: (code) {
                      print('QQQQQQQQQ ${code}');
                      if (code == "0000") {
                        print('QQQQQQQQQ');
                      }
                      _code = code;
                    },
                    onCodeChanged: (code) {
                      if (code!.length == 4) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        print('QQQQQQQQQ ${code}');
                        if (code == "0000") {
                          print('QQQQQQQQQ');
                        }
                        _code = code;
                      }
                    },
                  ),
                  const Spacer(),
                  const SizedBox(height: 40),

                  BlocBuilder<AuthBloc, AuthState>(
                      buildWhen: (previous, current) => previous != current,
                      builder: ((cxt, state) {
                        switch (state.loginState) {
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
                                  child: const Text('Check',
                                      style: TextStyle(color: Colors.black)),
                                  onPressed: () async {
                                    print('WWW ${_code}');

                                    if (_code.contains('0000')) {
                                      BlocProvider.of<AuthBloc>(context,
                                              listen: false)
                                          .add(PostLoginEvent(
                                              mobile: phoneNumber,
                                              OTP: "0000"));
                                    } else {
                                      showToast(
                                        state.loginMessage,
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
                                    // BlocProvider.of<AuthBloc>(context, listen: false)
                                    //     .add( CheckUserLoginStateEvent());
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
                                //       state.loginMessage,
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
                                      child: const Text('Check',
                                          style:
                                              TextStyle(color: Colors.black)),
                                      onPressed: () async {
                                        print('WWW ${_code}');

                                        if (_code == '0000') {
                                          BlocProvider.of<AuthBloc>(context,
                                                  listen: false)
                                              .add(PostLoginEvent(
                                                  mobile: phoneNumber,
                                                  OTP: "0000"));
                                        } else {
                                          showToast(
                                            state.loginMessage,
                                            context: context,
                                            animation:
                                                StyledToastAnimation.scale,
                                            reverseAnimation:
                                                StyledToastAnimation.fade,
                                            position:
                                                StyledToastPosition.bottom,
                                            animDuration:
                                                const Duration(seconds: 1),
                                            duration:
                                                const Duration(seconds: 4),
                                            curve: Curves.elasticOut,
                                            reverseCurve: Curves.linear,
                                          );
                                        }

                                        // BlocProvider.of<AuthBloc>(context, listen: false)
                                        //     .add( CheckUserLoginStateEvent());
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            );
                        }
                      })),

                  const Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ));
  }
}
