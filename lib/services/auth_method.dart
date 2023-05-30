import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign up user
  Future<String> signUpUser({
   // required String id,
    required String name,
    required String address,
    required String country,
    required String phoneNo,
    required String email,
    required String password,
    String role = 'user',
    required String profilepic
}) async{
    String res = "Some error occured";
    try{
      if(name.isNotEmpty || address.isNotEmpty || country.isNotEmpty || phoneNo.isNotEmpty || email.isNotEmpty || password.isNotEmpty || profilepic.isNotEmpty){
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        //Add user to firestore


        _firestore.collection('Users').doc(cred.user!.uid).set({
          'uid' : cred.user!.uid,
          'Name' : name,
          'Address': address,
          'Country' : country,
          'Phone': phoneNo,
          'Email': email,
          'Password': password,
          'role': role,
          'profilepic': profilepic
        });
        res = 'success';

      }
    } catch(err){
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password
})async {
    String res = 'Some error occured';
    try{
      if(email.isNotEmpty || password.isNotEmpty) {
        UserCredential _user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else{
        res = "Please enter all the fields";
      }
    }catch(err){
      res = err.toString();
    }
    return res;
  }
}