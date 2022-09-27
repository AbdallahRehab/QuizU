import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:quizu/core/services/services_locator.dart';
import 'package:quizu/core/utills/assets_manager.dart';
import 'package:quizu/features/quiz/presentation/bloc/quiz/quiz_bloc.dart';
import 'package:quizu/features/quiz/presentation/pages/quiz_screen.dart';
import 'package:sms_autofill/sms_autofill.dart';

class WrongAnswerScreen extends StatelessWidget {
  WrongAnswerScreen({Key? key}) : super(key: key);

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
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children:  [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Image(
                      image: AssetImage(ImageAssets.xIcon),
                      fit: BoxFit.contain,
                      height: 30,
                    ),
                  ),
                ],
              ),
              Spacer(flex: 3),

              const Padding(
                padding: EdgeInsets.all(8),
                child: Text("😢", style: TextStyle(fontSize:100 ,),textAlign: TextAlign.center),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text("Wrong Answer", style: TextStyle(fontSize: 20),textAlign: TextAlign.center),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(const Color(0xffD9D9D9)),
                      elevation: MaterialStateProperty.all(0),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15,horizontal: 25)),

                    ),

                    child: const Text('Try Again',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600)),
                    onPressed: () async {

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                            create: (_) =>
                            sl<QuizBloc>()..add(const GetQuestionsEvent()),
                            child: QuizScreen()),
                      ));
                    },
                  ),
                ],
              ),
              Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }

}
