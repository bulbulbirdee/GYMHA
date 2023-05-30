import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gymha/model/user_model.dart';
import 'package:gymha/services/authentication_repository.dart';
import 'package:gymha/services/user_repository.dart';

class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();

  //TextField controllers to get the data from the text fields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullname = TextEditingController();
  final country = TextEditingController();
  final address = TextEditingController();
  final phone = TextEditingController();
  final role = 'user';

  final userRepo = Get.put(UserRepository());

  void registerUser(String email, String password){
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
  }

  void loginUser(String email, String password){
    AuthenticationRepository.instance.loginWithEmailAndPassword(email, password);
  }

  Future<void> createUser(UserModel user) async{
    await userRepo.createUser(user);
    //phoneAuthentication(user.phoneNo);
    //Get.to(() => const OTPScreen());
  }

}