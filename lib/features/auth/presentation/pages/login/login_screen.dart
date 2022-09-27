import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:quizu/core/utills/assets_manager.dart';
import 'package:quizu/features/auth/presentation/pages/login/otp_screen.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

  String phoneNumber='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //QuizU ⏳
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("QuizU ",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w500)),
                  Image(
                    image: AssetImage(ImageAssets.sandClock),
                    fit: BoxFit.contain,
                    height: 35,
                  )
                ],
              ),
               SizedBox(height: 10.h),
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text("Mobile", style: TextStyle(fontSize: 15)),
              ),
              //phone
              IntlPhoneField(
                decoration: const InputDecoration(
                  hintText: "535555555",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'SA',
                onChanged: (phone) {
                  print(phone.completeNumber);
                  phoneNumber= phone.number;
                },
                onSubmitted: (phone) {
                  phoneNumber= phone;
                },
                dropdownIconPosition: IconPosition.trailing,
                onCountryChanged: (country) {},
                flagsButtonPadding: const EdgeInsets.symmetric(horizontal: 8),
              ),

              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xffD9D9D9)),
                      elevation: MaterialStateProperty.all(0),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 15, horizontal: 25)),
                    ),
                    child: const Text('Start',
                        style: TextStyle(color: Colors.black)),
                    onPressed: () async {
                      if(phoneNumber.isNotEmpty){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OtpScreen(phoneNumber:phoneNumber),
                        ));
                      }else{
                      showToast('Please,Enter your Phone',
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
          ),
        ),
      ),
    );
  }
}
