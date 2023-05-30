import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymha/screens/home_page.dart';

var MyAppBar = AppBar(
  backgroundColor: Color(0xFFc700c9),
);

var MyDrawer = Drawer(
  backgroundColor: Colors.grey.shade300,
  child: Column(
    children: [
      DrawerHeader(child: Image.asset("assets/images/logo-bg.png")),
      ListTile(
        leading: Icon(Icons.home),
        title: Text("H O M E"),
        onTap: (){
          Get.to(HomePage());
        },
      ),
      ListTile(
        leading: Icon(Icons.logout),
        title: Text("S E T T I N G S"),
      ),
      ListTile(
        leading: Icon(Icons.logout),
        title: Text("L O G O U T"),
        onTap: (){
          FirebaseAuth.instance.signOut();
          Get.to(HomePage());
         // Navigator.push(context, MaterialPageRoute(builder: (c) => HomePage()));
        },
      ),
    ],
  ),
);

var MyBcolor = Colors.grey.shade300;