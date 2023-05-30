import 'package:flutter/material.dart';
import 'package:gymha/admin_widgets/admin_dashboard.dart';
import 'package:gymha/admin_widgets/admin_dashboard_components/anime_holder.dart';
import 'package:gymha/admin_widgets/admin_dashboard_components/app_info_banner.dart';
import 'package:gymha/admin_widgets/admin_dashboard_components/redirect_nav.dart';
import 'package:gymha/admin_widgets/admin_dashboard_components/redirection_card.dart';
import 'package:gymha/admin_widgets/admin_dashboard_components/side_menu.dart';
import 'package:gymha/admin_widgets/admin_dashboard_components/top_info_card.dart';
import 'package:gymha/admin_widgets/admin_models/dashboard_headings.dart';
import 'package:gymha/widgets/dashboard.dart';
import 'package:gymha/widgets/responsive.dart';

class AdminDashboard extends StatefulWidget {
  AdminDashboard({Key? key,
  //  required this.children
  }) : super(key: key);

  //final List<Widget> children;


  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  get children => null;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: MediaQuery.of(context).size.width>1200? null: AppBar(
        backgroundColor: Color(0xFF183038),
        leading: Builder(
          builder: (context) =>
              IconButton(
                onPressed: (){
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu),),
        )
      ),
      drawer: SideMenu(),
      body: Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFFE4AFB0),
              Color(0xFF9A7787)
            ],
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp
        ),
        ),
        constraints: BoxConstraints(maxWidth: 1440 ),
        child: Row(
          children: [
            if(MediaQuery.of(context).size.width>1200)
            Expanded(
              flex: 2,
                child: SideMenu()
            ),
            SingleChildScrollView(
             // scrollDirection: Axis.vertical,
             child:
              SizedBox(
                height: 1500,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppInfoBanner(),
                      SizedBox(height: 50,),
                      Text("User Management",
                        style: Theme.of(context).textTheme.headline3,),
                      SizedBox(height: 10,),
                     UserRedirectNav(),
                      Text("Course Management",
                        style: Theme.of(context).textTheme.headline3,),
                      SizedBox(height: 10,),
                      CourseRedirectNav(),
                      Text("Social Management",
                        style: Theme.of(context).textTheme.headline3,),
                      SizedBox(height: 10,),
                      SocialRedirectNav(),
                      Text("Counselling Management",
                        style: Theme.of(context).textTheme.headline3,),
                      SizedBox(height: 10,),
                      CounsellingRedirectNav(),
                      SizedBox(height: 30,)
                    ],
                  ),
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}









