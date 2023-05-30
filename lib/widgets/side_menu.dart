import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymha/screens/home_page.dart';
import 'package:gymha/screens/user_side_screens/feedback_dialog.dart';
import 'package:gymha/screens/user_side_screens/profile_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset("assets/images/logo-bg.png"),
            ),
            SizedBox(height: 10,),
            DrawerListTitle(title: "My Profile", svgSrc: Icons.person_pin_outlined, press: (){
              Navigator.push(context, MaterialPageRoute(builder: (c) => ProfileScreen()));
            },),
            DrawerListTitle(title: "Notifications", svgSrc: Icons.notifications_active_outlined, press: (){},),
            DrawerListTitle(title: "My Courses", svgSrc: Icons.book_outlined, press: (){},),
            DrawerListTitle(title: "My Certifications", svgSrc: Icons.add_chart_outlined, press: (){},),
            DrawerListTitle(title: "Transactions", svgSrc: Icons.attach_money, press: (){},),
            DrawerListTitle(title: "Feedback Form", svgSrc: Icons.feedback_outlined, press: (){
              Navigator.push(context, MaterialPageRoute(builder: (c) => FeedbackDialog()));
            },),
            DrawerListTitle(title: "Logout", svgSrc: Icons.logout, press: ()
            {
              FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (c) => HomePage()));
              },)
          ],
        ),
      ),
    );
  }
}

class DrawerListTitle extends StatelessWidget {
  const DrawerListTitle({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title;
  final IconData svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(svgSrc, color: Colors.black87, size: 16,),
      title: Text(title),
    );
  }
}
