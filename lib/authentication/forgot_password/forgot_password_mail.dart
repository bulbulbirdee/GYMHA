import 'package:flutter/material.dart';
import 'package:gymha/authentication/forgot_password/otp_screen.dart';
import 'package:gymha/authentication/pallete.dart';

class ForgotPasswordMail extends StatelessWidget {
  const ForgotPasswordMail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
              child: Column(
                  children: [
                    Image.asset('assets/images/signin_balls.png'),
                    const Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Pallete.gradient1,
                        fontSize: 50,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const Text(
                      'Please enter your Email Address',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Pallete.gradient1,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 50,),
                    Form(child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: w/3.5),
                          child: TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Pallete.gradient1,
                                      width: 3,
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Pallete.gradient2,
                                      width: 3,
                                    )
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.grey),
                                icon: Icon(
                                  Icons.email,
                                  color: Pallete.gradient2,
                                )
                            ),
                          ),
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
                      ],
                    ))
                  ]
              )
          )
      )
    );
  }
}
