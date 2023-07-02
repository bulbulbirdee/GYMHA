import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymha/controllers/MenuController.dart';

import 'package:gymha/screens/home_page.dart';
import 'package:gymha/screens/user_page.dart';
import 'package:gymha/services/signup_email_password_failure.dart';
import 'package:gymha/widgets/dashboard.dart';
import 'package:provider/provider.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  String email = "";
  String password = "";

  //Variable
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady(){
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user){
    if(user == null){
      Get.offAll(() => HomePage());
    }
    else{
      print("here");
      // if(checkRole() == 'admin')
      //   {print("Admin");}
     // else
        if(checkRole(user) == 'user')
        {print("Users");}
      // Get.offAll(() =>MultiProvider(
      //     providers: [
      //       ChangeNotifierProvider(
      //         create: (content) => MenuController(),
      //       )
      //     ],
      //     child: UserPage()));
    }

  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async{
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() =>  MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (content) => MenuController(),
            )
          ],
          child: UserPage())) : Get.to(() => HomePage());
    } on FirebaseAuthException catch(e){
      final ex = SignUpEmailPasswordFailure.code(e.code);
      print('FIREBASE  AUTH EXCEPTION - ${ex.message}');
      throw ex;
    }
    catch(_){
      const ex = SignUpEmailPasswordFailure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async{
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // firebaseUser.value != null ? Get.offAll(() =>  MultiProvider(
      //     providers: [
      //       ChangeNotifierProvider(
      //         create: (content) => MenuController(),
      //       )
      //     ],
      //     child: UserPage())) : Get.to(() => HomePage());
    } on FirebaseAuthException catch(e){
    }
    catch(_){
    }
  }

  checkRole(User? user) async {

    // User? currentUser;
     print('reaching here in checkRole');
    // await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: email,
    //     password: password
    // ).then((fAuth) {
    //   currentUser = fAuth.user;
    // }).catchError((onError) {
      //display error message
      // final snackBar = SnackBar(
      //   content: Text(
      //     "Error Occured" + onError.toString(),
      //     style: const TextStyle(
      //         fontSize: 26,
      //         color: Colors.white
      //     ),
      //   ),
      //   backgroundColor: Colors.purple,
      //   duration: const Duration(seconds: 5),
      // );
      //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
   // });


    if (user != null) {
      //check if user exists in firestore
      print('reaching here in checkRole null brac');

     // var userData = FirebaseFirestore.instance.collection("Users").document("uid").get();



      await FirebaseFirestore
          .instance
          .collection("Users")
          .doc(user.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {

            print('Here too');
            print(user.uid);

        if (documentSnapshot.exists) {
          print(documentSnapshot.get('role'));
         // Map<String, dynamic> data = snap.data()!;
         // var role = data['role'];

          // if (role == 'user') {
          //   print("user");
          //   return "user";
          //
          //   // //Navigator.push(context, MaterialPageRoute(builder: (c) => UserPage()));
          //   // Navigator.push(context, MaterialPageRoute(
          //   //   builder: (c) {
          //   //     var changeNotifierProvider = ChangeNotifierProvider(
          //   //         create: (context) => MenuController(),
          //   //         child: UserPage()
          //   //     );
          //   //     return changeNotifierProvider;
          //   //   },
          //   // ),
          //   // );
          // }
          // else if (role == 'admin') {
          //   print("admin");
          //   return "admin";
          // }
          // Navigator.push(context, MaterialPageRoute(builder: (c) => AdminPage()));
          //}
        }
        else{print("No snap");}
        // else {
        //   // SnackBar snackBar = const SnackBar(
        //   //   content: Text(
        //   //     "No record found" ,
        //   //     style: TextStyle(
        //   //         fontSize: 26,
        //   //         color: Colors.white
        //   //     ),
        //   //   ),
        //   //   backgroundColor: Colors.purple,
        //   //   duration: Duration(seconds: 5),
        //   // );
        //   //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // }
      });
    }
  }
}