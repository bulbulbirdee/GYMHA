import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymha/authentication/pallete.dart';

import 'package:gymha/screens/user_side_screens/update_profile_screen.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //DocumentReference ref = FirebaseFirestore.instance.doc()

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(onPressed: () =>  Get.back(), icon: const Icon(Icons.arrow_back, color: Color(0xFFc700c9),)),
        title: Text("PROFILE", style: TextStyle(
          color: Color(0xFFc700c9),
          fontSize: 26,
          fontFamily: 'Cinzel',
          fontWeight: FontWeight.w900,
          letterSpacing: 3,
        ),),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Pallete.gradient1,
            Pallete.gradient2,
            Pallete.gradient3
          ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight
          ),
        ),
            padding: EdgeInsets.all(30),
            child: Column(
              children: [

                const SizedBox(height: 30,),
                const Divider(),
                const SizedBox(height: 10,),

                //MENU
                ProfileMenuWidget(title: "Settings", icon: LineAwesomeIcons.cog, onPress: (){}),
                ProfileMenuWidget(title: "Billing Details", icon: LineAwesomeIcons.wallet, onPress: (){}),
                //ProfileMenuWidget(title: "User Management", icon: LineAwesomeIcons.user_check, onPress: (){}),
                Divider(thickness: 0.5,),
                const SizedBox(height: 10,),
                ProfileMenuWidget(title: "Information", icon: LineAwesomeIcons.info, onPress: (){}),
                ProfileMenuWidget(
                    title: "Logout",
                    icon: LineAwesomeIcons.alternate_sign_out,
                    textColor:Colors.red,
                    endIcon: false,
                    onPress: (){}
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => const UpdateProfileScreen()),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, side: BorderSide.none, shape: const StadiumBorder()
                    ),
                    child: Text("Edit Profile", style: TextStyle(color: Color(0xFFc700c9) ),),
                  ),
                ),
              ],
            ),
          ),
       // ),
     // ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key, required this.title, required this.icon, required this.onPress, this.endIcon = true, this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon ;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white.withOpacity(0.15)
        ),
        child: Icon(icon, color: Colors.white,),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyText1?.apply(color: textColor),),
      trailing: endIcon? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.15),
        ),
        child: const Icon(LineAwesomeIcons.angle_right, size: 18, color: Colors.white,),
      ): null,
    );
  }
}
