import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymha/admin_widgets/admin_util/view_user_panel.dart';
import 'package:gymha/authentication/pallete.dart';
import 'package:gymha/controllers/profile_controller.dart';
import 'package:gymha/model/user_model.dart';
import 'package:gymha/widgets/UserHeader.dart';
import 'package:gymha/widgets/newsletter_widgets/blog_panel.dart';
import 'package:gymha/widgets/responsive.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AdminViewUsers extends StatelessWidget {
  const AdminViewUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final controller = Get.put(ProfileController());

    bool isMobile = ResponsiveWidget.isSmallScreen(context)? true : false;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 5,
            leading: Padding(
              padding: const EdgeInsets.all(15.0),
              child: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back, color: Color(0xFF7c2dcb),)),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 13.0),
              child: Text("View All Users", style: TextStyle(
                color: Color(0xFF7c2dcb),
                fontSize: isMobile? 16: 20,
                fontWeight: FontWeight.w500,
              ),),
            ),
          ),
        ),

        body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [

                  ],
                ),
                Container(
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
                    padding: EdgeInsets.all(10),
                    child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: w/10),
                            child:
                            StreamBuilder(
                                stream: FirebaseFirestore.instance.collection('Users').snapshots(),
                                builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot)
                                {
                                  if(snapshot.connectionState == ConnectionState.waiting){
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) => ViewUserPanel(
                                      snap: snapshot.data!.docs[index].data(),
                                    ),
                                  );

                                }
                            )
                          )
                        ])
                ),
              ],
            )
        )
    );

  }
}









