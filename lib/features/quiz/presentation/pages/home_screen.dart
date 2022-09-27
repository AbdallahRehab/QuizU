import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizu/core/services/services_locator.dart';
import 'package:quizu/features/quiz/presentation/bloc/quiz/quiz_bloc.dart';
import 'package:quizu/features/quiz/presentation/pages/quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

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
              Spacer(flex: 3),
              Padding(
                padding: EdgeInsets.all(8),
                child:
                    Text("Ready to test your knoweldge and challenge others?",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center),
              ),
              const SizedBox(height: 20),
              Spacer(),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xffD9D9D9)),
                      elevation: MaterialStateProperty.all(0),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 15, horizontal: 25)),
                    ),
                    child: const Text('Quiz Me!',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600)),
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                            create: (_) =>
                                sl<QuizBloc>()..add(const GetQuestionsEvent()),
                            child: QuizScreen()),
                      ));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                    "Answer as much questions correctly within 2 minutes",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center),
              ),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
