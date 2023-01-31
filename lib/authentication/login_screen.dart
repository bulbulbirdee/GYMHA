import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymha/screens/admin_page.dart';
import 'package:gymha/screens/home_page.dart';
import 'package:gymha/screens/user_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();


}

class _LoginScreenState extends State<LoginScreen> {

  String email = "";
  String password = "";

  allowUserLogin() async
  {


    SnackBar snackBar = const SnackBar(
      content: Text(
        "Checking Credentials" ,
        style: TextStyle(
            fontSize: 26,
            color: Colors.white
        ),
      ),
      backgroundColor: Colors.purple,
      duration: Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    User? currentUser;
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((fAuth)
    {
      currentUser = fAuth.user;
    }).catchError((onError)
    {
      //display error message
      final snackBar = SnackBar(
        content: Text(
          "Error Occured" + onError.toString(),
          style: const TextStyle(
            fontSize: 26,
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.purple,
        duration: const Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    if(currentUser != null)
      {
        //check if user exists in firestore
        await FirebaseFirestore
            .instance
            .collection("users")
            .doc(currentUser!.uid)
            .get()
            .then((snap)
            {
              if(snap.exists)
                {
                  Map<String, dynamic> data = snap.data()!;
                  var role = data['role'];

                  if(role == 'admin')
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c) => UserPage()));
                    }
                  else if(role == 'user')
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c) => AdminPage()));
                    }
                }
              else{
                SnackBar snackBar = const SnackBar(
                  content: Text(
                    "No record found" ,
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.white
                    ),
                  ),
                  backgroundColor: Colors.purple,
                  duration: Duration(seconds: 5),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            });
      }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x0Dc700c9),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo-bg.png"
                  ),
                  SizedBox(height: 20,),

                  //email address
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                      onChanged: (value)
                        {
                        email = value;
                        },
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepPurple,
                                  width: 2,
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.purpleAccent,
                                  width: 2,
                                )
                            ),
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.grey),
                            icon: Icon(
                              Icons.email,
                              color: Colors.deepPurple,
                            )
                        ),
                      ),

                    SizedBox(height: 10,),
                    //password
                    TextField(
                      onChanged: (value)
                      {
                        password = value;
                      },
                      obscureText: true,
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepPurple,
                                width: 2,
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.purpleAccent,
                                width: 2,
                              )
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          icon: Icon(
                            Icons.password,
                            color: Colors.deepPurple,
                          )
                      ),
                    ),

                    SizedBox(height: 30,),
                    //Login Button
                    ElevatedButton(
                        onPressed: (){

                          allowUserLogin();


                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 60, vertical: 20)),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.purpleAccent),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                              fontSize: 16
                          ),
                        )
                    )

                    ]

                  )

                  
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
