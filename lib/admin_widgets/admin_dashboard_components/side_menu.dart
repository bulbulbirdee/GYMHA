import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymha/admin_widgets/admin_dashboard_components/admin_info.dart';
import 'package:gymha/admin_widgets/admin_dashboard_components/logo_info.dart';
import 'package:gymha/admin_widgets/admin_dashboard_components/side_menu.dart';
import 'package:gymha/screens/home_page.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFED7BF)
          // gradient: LinearGradient(
          //     colors: [
          //       Colors.white54,
          //       Color(0xFFE4AFB0),
          //       Color(0xFF9A7787)
          //     ],
          //     stops: [0.0, 0.3, 1.0],
          //     begin: FractionalOffset.topCenter,
          //     end: FractionalOffset.bottomCenter,
          //     tileMode: TileMode.repeated
          // ),
        ),
        child: Column(
          children: [
            //Spacer(flex: 2,),
            LogoInfo(),
            Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child:  Column(
                    children: [
                      AdminInfo(title: "Name", text: "Admin Name"),
                      AdminInfo(title: "Email", text: "Admin Email"),
                      Divider(color:  Color(0xFF183038), thickness: 1,),
                      ListTile(
                        leading: Icon(Icons.home, color: Color(0xFF183038)),
                        title: Text("Home", style: TextStyle(color: Color(0xFF183038))),
                        onTap: (){
                          Get.to(HomePage());
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings, color:Color(0xFF183038),),
                        title: Text("Settings", style: TextStyle(color: Color(0xFF183038)),),
                      ),
                      ListTile(
                        leading: Icon(Icons.logout, color: Colors.black87),
                        title: Text("Logout", style: TextStyle(color: Colors.black87)),
                        onTap: (){
                          FirebaseAuth.instance.signOut();
                          Get.to(HomePage());
                          // Navigator.push(context, MaterialPageRoute(builder: (c) => HomePage()));
                        },
                      ),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}





