import 'package:flutter/material.dart';
import 'package:quizu/core/utills/assets_manager.dart';
import 'package:social_share/social_share.dart';

class ResultScreen extends StatelessWidget {
  final int scoreUserInQuiz;

  ResultScreen({Key? key, required this.scoreUserInQuiz}) : super(key: key);

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
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                child: Image(
                  image: AssetImage(ImageAssets.resultIcon),
                  fit: BoxFit.contain,
                  height: 120,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                    "You have completed \n $scoreUserInQuiz \n correct answers!",
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 15, horizontal: 25)),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.share_outlined, color: Colors.black),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Share',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    onPressed: () async {
                      showGeneralDialog(
                        context: context,
                        barrierLabel: "Barrier",
                        barrierDismissible: true,
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionDuration: Duration(milliseconds: 700),
                        pageBuilder: (_, __, ___) {
                          return Center(
                            child: Container(
                              height: 240,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40)),
                              child: SizedBox.expand(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8)),
                                      elevation: MaterialStateProperty.all(0),
                                    ),
                                    onPressed: () async {
                                      SocialShare.shareTwitter(
                                        "I answered ${scoreUserInQuiz} correct answers in QuizU!",
                                        hashtags: ["Quizu", "Okoul", "score"],
                                        url: "https://www.okoul.com/",
                                        trailingText: "\n",
                                      ).then((data) {
                                        print(data);
                                      });
                                    },
                                    child: Image(
                                      image:
                                          AssetImage(ImageAssets.twitterIcon),
                                      fit: BoxFit.contain,
                                      height: 50,
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8)),
                                      elevation: MaterialStateProperty.all(0),
                                    ),
                                    onPressed: () async {
                                      SocialShare.shareSms(
                                        "I answered ${scoreUserInQuiz} correct answers in QuizU!e",
                                        url: "\nhttps://www.okoul.com/",
                                        trailingText: "\n",
                                      ).then((data) {
                                        print(data);
                                      });
                                    },
                                    child: Image(
                                      image: AssetImage(ImageAssets.smsIcon),
                                      fit: BoxFit.contain,
                                      height: 50,
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8)),
                                      elevation: MaterialStateProperty.all(0),
                                    ),
                                    onPressed: () async {
                                      SocialShare.shareWhatsapp(
                                        "I answered ${scoreUserInQuiz} correct answers in QuizU! \n https://www.okoul.com/",
                                      ).then((data) {
                                        print(data);
                                      });
                                    },
                                    child: Image(
                                      image:
                                          AssetImage(ImageAssets.whatsappIcon),
                                      fit: BoxFit.contain,
                                      height: 50,
                                    ),
                                  ),
                                ],
                              )),
                            ),
                          );
                        },
                        transitionBuilder: (_, anim, __, child) {
                          Tween<Offset> tween;
                          if (anim.status == AnimationStatus.reverse) {
                            tween =
                                Tween(begin: Offset(-1, 0), end: Offset.zero);
                          } else {
                            tween =
                                Tween(begin: Offset(1, 0), end: Offset.zero);
                          }

                          return SlideTransition(
                            position: tween.animate(anim),
                            child: FadeTransition(
                              opacity: anim,
                              child: child,
                            ),
                          );
                        },
                      );
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
