import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gymha/model/user_model.dart';
import 'package:gymha/services/authentication_repository.dart';
import 'package:gymha/services/user_repository.dart';

class ProfileController extends GetxController{
  static ProfileController get instance => Get.find();


  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  // firebaseUser = Rx<User?>(_auth.currentUser);
  // firebaseUser.bindStream(_auth.userChanges());
  // ever(firebaseUser, _setInitialScreen);

  //Get the user email and pass to userRepository to fetch user record
  getUserData() async{
    // final email = firebaseUser.value?.email;
    // if(email != null){
    //   return _userRepo.getUserDetails(email);
    // }
    // else{
    //   Get.snackbar("Error", "Login to continue");
    // }

    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get();
   // return snap;

    final userData = UserModel(
      id: (snap.data() as Map<String, dynamic>)['uid'],
      name: (snap.data() as Map<String, dynamic>)['Name'],
      address: (snap.data() as Map<String, dynamic>)['Address'],
      country: (snap.data() as Map<String, dynamic>)['Country'],
      phoneNo: (snap.data() as Map<String, dynamic>)['Phone'],
      email: (snap.data() as Map<String, dynamic>)['Email'],
      password: (snap.data() as Map<String, dynamic>)['Password'],
      profilepic : (snap.data() as Map<String, dynamic>)['profilepic'],
    );

    return userData;
  }

  //Fetch list of all users
  Future<List<UserModel>> getAllUsers() async => await _userRepo.allUser();

  updateRecord(UserModel user) async{
    await _userRepo.updateUserRecord(user);
  }

  DeleteRecord(UserModel user) async{
    await _userRepo.DeleteUserRecord(user);
  }
}