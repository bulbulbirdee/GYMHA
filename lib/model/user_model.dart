

import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

User? currentUser;

class UserModel{
  final String? id;
  final String name;
  final String address;
  final String country;
  final String phoneNo;
  final String email;
  final String password;
  final String role;
  final String? profilepic;

  const UserModel(
  {
    this.id,
    required this.name,
    required this.address,
    required this.country,
    required this.phoneNo,
    required this.email,
    required this.password,
    this.role = 'user',
    this.profilepic
  });

  toJson(){
    return{
      'Name' : name,
      'Address': address,
      'Country' : country,
      'Phone': phoneNo,
      'Email': email,
      'Password': password,
      'role': role,
      'profilepic': profilepic
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return UserModel(
        id: currentUser?.uid,
        name: data["Name"],
        address: data["Address"],
        country: data["Country"],
        phoneNo: data["Phone"],
        email: data["Email"],
        password: data["Password"],
        profilepic: data['profilepic']
    );

  }
}