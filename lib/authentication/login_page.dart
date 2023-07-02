import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymha/admin_widgets/admin_dashboard.dart';
import 'package:gymha/authentication/forgot_password/forgot_password_mail.dart';
import 'package:gymha/authentication/forgot_password/forgot_password_phone.dart';
import 'package:gymha/authentication/gradient_button.dart';
import 'package:gymha/authentication/login_field.dart';
import 'package:gymha/authentication/pallete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymha/controllers/MenuController.dart';
import 'package:gymha/controllers/sign_up_controller.dart';
import 'package:gymha/model/user_model.dart';

import 'package:gymha/screens/home_page.dart';
import 'package:gymha/screens/user_page.dart';
import 'package:gymha/services/auth_method.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final controller = Get.put(SignUpController());

  String email = "";
  String password = "";
  bool _isLoading  = false;


  void loginUser() async{
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email : controller.email.text.trim(),
      password : controller.password.text.trim(),
    );
    if(res == "Success"){
      Fluttertoast.showToast(
          msg: res,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          webPosition: "center",
          fontSize: 16.0,
          webBgColor: "linear-gradient(to right, #ff02fd, #11998e)"
      );
      route();
      setState(() {
        _isLoading = false;
      });
    }
    else{
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: res,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          webPosition: "center",
          fontSize: 16.0,
          webBgColor: "linear-gradient(to right, #ff02fd, #11998e)"
      );

    }

  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  AdminDashboard(),
            ),
          );
        }else{
        //  print("Admin");
          Navigator.push(context, MaterialPageRoute(
            builder: (c) {
              var changeNotifierProvider = ChangeNotifierProvider(
                  create: (context) => MenuController(),
                  child: UserPage()
              );
              return changeNotifierProvider;
            },
          ),
          );
        }
      } else {
        print('Some issue occured');
      }
    });
  }

  @override
  Widget build(BuildContext context) {



  //  List images = ["google.png", "facebook.png"];

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/signin_balls.png'),
              const Text(
                'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Pallete.whiteColor,
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 50,),
          //email address
              ConstrainedBox(constraints: const BoxConstraints(
                maxWidth: 400,
              ),
            child: TextField(
                // onChanged: (value)
                // {
                //   email = value;
                // },
              controller: controller.email,
                style: const TextStyle(fontSize: 16, color: Pallete.whiteColor),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Pallete.borderColor,
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
              const SizedBox(height: 15,),
              //password
              ConstrainedBox(constraints: const BoxConstraints(
                maxWidth: 400,
              ),
              child: TextField(
                // onChanged: (value)
                // {
                //   password = value;
                // },
                controller: controller.password,
                obscureText: true,
                style: const TextStyle(fontSize: 16, color: Pallete.whiteColor),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Pallete.borderColor,
                          width: 3,
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Pallete.gradient2,
                          width: 3,
                        )
                    ),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey),
                    icon: Icon(
                      Icons.password,
                      color: Pallete.gradient2,
                    )
                ),
              ),
          ),


              //Forgot Password


              SizedBox(height: 30,),

              //Sign in button
              Column(
                children: [
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
                      (onPressed: loginUser,
                    // {
                    //   SignUpController.instance.loginUser(
                    //     controller.email.text.trim(),
                    //    controller.password.text.trim()
                    //         );
                    //
                    // },
                      child: _isLoading? const Center(child: CircularProgressIndicator(color:  Pallete.whiteColor,),)
                      : const Text('SIGN IN',
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
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: (){
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            context: context,
                            builder: (context)=>Container(
                              padding: EdgeInsets.all(w/60),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text("Make Selection!", style: Theme.of(context).textTheme.headline3,),
                                  Text("Select of the following options to reset your password", style: Theme.of(context).textTheme.bodyText2,),
                                  const SizedBox(height: 30),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (c) => ForgotPasswordPhone()));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.purple,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.mobile_friendly_rounded, size: 50,),
                                          const SizedBox(width: 10,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Phone No", style: Theme.of(context).textTheme.headline6,),
                                              Text("Reset via Phone verification", style: Theme.of(context).textTheme.bodyText2,)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (c) => ForgotPasswordMail()));
                                      },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.purple,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.mail_outline_rounded, size: 50,),
                                          const SizedBox(width: 10,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("E-mail", style: Theme.of(context).textTheme.headline6,),
                                              Text("Reset via Email verification", style: Theme.of(context).textTheme.bodyText2,)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),);
                      },
                      child: const Text("Forgot Password?"),
                    ),
                  ),
                ],
              ),
              
              
              
              SizedBox(height: 20,),
              RichText(text: TextSpan(
                text: "Don\'t have an account?",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20
                ),
                children: [
                  TextSpan(
                  text: " CREATE",
                  style: TextStyle(
                      color: Pallete.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ))
                ]
              )
              ),
              SizedBox(height: w*0.1,),
              // RichText(text: TextSpan(
              //     text: "Sign In using one of the following methods",
              //     style: TextStyle(
              //         color: Colors.grey,
              //         fontSize: 16
              //     ),
              // )
              // ),
              // SizedBox(height: 10,),
              // Wrap(
              //   children: List<Widget>.generate(
              //       2,
              //           (index){
              //         return Padding(
              //           padding: const EdgeInsets.all(10.0),
              //           child: CircleAvatar(
              //             radius: 30,
              //             backgroundColor: Pallete.backgroundColor,
              //             child: CircleAvatar(
              //               radius: 23,
              //               backgroundImage: AssetImage(
              //                 "assets/images/auth_file/"+images[index]
              //               ),
              //             ),
              //           ),
              //         );
              //           }),
              // )
          ])
        ),
      ),
    );
  }
}
