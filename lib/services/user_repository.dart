import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymha/controllers/MenuController.dart';
import 'package:gymha/model/user_model.dart';
import 'package:gymha/screens/user_page.dart';
import 'package:provider/provider.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  bool accountRegistered = false;

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async{

    await _db.collection("Users").add(user.toJson())
        .whenComplete(
            () {
                Get.snackbar("Success", "Your account has been created.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green.withOpacity(0.1),
                colorText: Colors.green,);
             // return accountRegistered = true;
            }
    )
        .catchError((error, stackTrace){
          Get.snackbar("Error", "Something went wrong. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
          print(error.toString());
    });
  }

  //Fetch all users or user details
  Future<UserModel> getUserDetails(String email) async{
    final snapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserModel>> allUser() async{
    final snapshot = await _db.collection("Users").get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<void> updateUserRecord(UserModel user) async{
    await _db.collection("Users").doc(user.id).update(user.toJson());
  }

  Future<void> DeleteUserRecord(UserModel user) async{
    await _db.collection("Users").doc(user.id).delete();
  }
}