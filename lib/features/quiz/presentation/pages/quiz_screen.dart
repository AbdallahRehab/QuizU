import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:quizu/core/utills/assets_manager.dart';
import 'package:quizu/core/utills/enums.dart';
import 'package:quizu/features/quiz/presentation/bloc/quiz/quiz_bloc.dart';
import 'package:quizu/features/quiz/presentation/pages/result_screen.dart';
import 'package:quizu/features/quiz/presentation/pages/wrong_answer_screen.dart';
import 'package:sizer/sizer.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimerCountdown(
                    format: CountDownTimerFormat.minutesSeconds,
                    timeTextStyle: TextStyle(fontSize: 50),
                    enableDescriptions: false,
                    endTime: DateTime.now().add(
                      const Duration(
                        minutes:   2,
                      ),
                    ),
                    onEnd: () {
                      print("Timer finished");
                      BlocProvider.of<QuizBloc>(context).add(PostScoreEvent(
                          Score:
                              "${BlocProvider.of<QuizBloc>(context).state.scoreUserInQuiz}"));
                      int score = BlocProvider.of<QuizBloc>(context)
                          .state
                          .scoreUserInQuiz;
                      Timer(Duration(seconds: 3), () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              ResultScreen(scoreUserInQuiz: score),
                        ));
                      });
                    },
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  const Image(
                    image: AssetImage(ImageAssets.sandClock),
                    fit: BoxFit.contain,
                    height: 40,
                  )
                ],
              ),
              BlocBuilder<QuizBloc, QuizState>(builder: ((context, state) {
                switch (state.questionsState) {
                  case RequestState.loading:
                    return const SizedBox(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  case RequestState.loaded:
                    return Expanded(
                        child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                              state.questions[state.changeNumberOfQuestion]
                                  .Question!,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center),
                        ),
                        const SizedBox(height: 10),
                        BlocConsumer<QuizBloc, QuizState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      String keySelected = index == 0
                                          ? "a"
                                          : index == 1
                                              ? "b"
                                              : index == 2
                                                  ? "c"
                                                  : "d";
                                      BlocProvider.of<QuizBloc>(context)
                                          .updateIndexSelectedAnswer(
                                              value: index,
                                              keySelected: keySelected,
                                              correctAnswer: state
                                                  .questions[BlocProvider.of<
                                                          QuizBloc>(context)
                                                      .state
                                                      .changeNumberOfQuestion]
                                                  .correct!);

                                      if (!BlocProvider.of<QuizBloc>(context)
                                          .state
                                          .isCorrect) {
                                        print('FFFFFFFFFFFFFFFFFFFFFFFFF');
                                        Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                          builder: (context) =>
                                              WrongAnswerScreen(),
                                        ));
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: BlocProvider.of<QuizBloc>(
                                                        context)
                                                    .state
                                                    .changeIndexSelectedAnswer ==
                                                index
                                            ? (BlocProvider.of<QuizBloc>(
                                                        context)
                                                    .state
                                                    .isCorrect
                                                ? Colors.green
                                                : Colors.redAccent)
                                            : Colors.white,
                                      ),
                                      child: Center(
                                        child: Text(
                                            index == 0
                                                ? state
                                                    .questions[BlocProvider.of<
                                                            QuizBloc>(context)
                                                        .state
                                                        .changeNumberOfQuestion]
                                                    .a!
                                                : index == 1
                                                    ? state
                                                        .questions[BlocProvider
                                                                .of<QuizBloc>(
                                                                    context)
                                                            .state
                                                            .changeNumberOfQuestion]
                                                        .b!
                                                    : index == 2
                                                        ? state
                                                            .questions[BlocProvider.of<QuizBloc>(context)
                                                                .state
                                                                .changeNumberOfQuestion]
                                                            .c!
                                                        : state
                                                            .questions[BlocProvider.of<QuizBloc>(context)
                                                                .state
                                                                .changeNumberOfQuestion]
                                                            .d!,
                                            style: TextStyle(
                                                color: BlocProvider.of<QuizBloc>(context)
                                                            .state
                                                            .changeIndexSelectedAnswer ==
                                                        index
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 15)),
                                      ),
                                    ),
                                  );
                                },
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 55,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                itemCount: 4,
                              );
                            }),
                        SizedBox(height: 50),
                        Row(
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
                              child: const Text('Skip 🔥',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                              onPressed: () async {
                                if (BlocProvider.of<QuizBloc>(context)
                                        .state
                                        .isSkip ==
                                    false) {
                                  BlocProvider.of<QuizBloc>(context)
                                      .updateNumberOfQuestion();
                                } else {
                                  showToast(
                                    "Skip to use only once",
                                    context: context,
                                    animation: StyledToastAnimation.scale,
                                    reverseAnimation: StyledToastAnimation.fade,
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
                        ),
                      ],
                    ));
                  case RequestState.error:
                    return SizedBox(
                      height: 200.0,
                      child: Center(
                        child: Text(state.questionsMessage),
                      ),
                    );
                }
              })),
            ],
          ),
        ),
      ),
    );
  }
}
