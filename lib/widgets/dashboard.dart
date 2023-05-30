import 'package:flutter/material.dart';
import 'package:gymha/util/util.dart';
import 'package:gymha/widgets/UserHeader.dart';
import 'package:gymha/widgets/bottom_bar.dart';
import 'package:gymha/widgets/featured_dashboard_courses.dart';
import 'package:gymha/widgets/last_course_card.dart';
import 'package:gymha/widgets/main_heading.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFff02fd),
      // appBar: AppBar(
      //   title: Text("Dashboard"),
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            UserHeader(),
            SizedBox(height: 30,),
            LastCourseCard(),
            SizedBox(height: 30,),
            FeaturedCourses(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Util.openShoppingCart(context);
        },
        child: Icon(Icons.shopping_cart),
        backgroundColor: Color(0xFF11998e),
      ),


    );
  }


}

