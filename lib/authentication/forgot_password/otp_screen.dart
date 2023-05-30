import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gymha/authentication/pallete.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/signin_balls.png'),
              const Text(
                'CO\nDE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Pallete.gradient1,
                  fontSize: 50,
                  fontFamily: 'inter'
                ),
              ),
              const SizedBox(height: 20,),
              const Text(
                'VERIFICATION',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Pallete.gradient1,
                  fontSize: 10,
                ),
              ),

              const SizedBox(height: 40,),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w/10),
                  child: const Text(
                    'Enter the verification code sent at support@gmail.com',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Pallete.gradient1,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20,),
              OtpTextField(
                mainAxisAlignment: MainAxisAlignment.center,
                numberOfFields: 6,
                fillColor: Colors.black.withOpacity(0.1),
                filled: true,
                onSubmit: (code){print('OTP => $code');},
              ),
              const SizedBox(height:  20,),
              Container(
                decoration:  BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Pallete.gradient1,
                      Pallete.gradient2,
                      Pallete.gradient3
                    ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight
                    ),
                    borderRadius: BorderRadius.circular(7)
                ),
                child: ElevatedButton
                  (onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) => OTPScreen()));
                },
                  child: const Text('NEXT',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(395, 55),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent
                  ),
                ),
              ),
              SizedBox(height: 40,)
            ],

          ),
        ),
      ),
    );
  }
}
