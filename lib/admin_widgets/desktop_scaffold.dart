import 'package:flutter/material.dart';
import 'package:gymha/admin_widgets/admin_newsletter.dart';
//import 'package:gymha/admin_widgets/admin_courses.dart';
import 'package:gymha/admin_widgets/admin_util/constant_routes.dart';
import 'package:gymha/admin_widgets/admin_util/redirect_card.dart';

import 'package:gymha/admin_widgets/constants.dart';
import 'package:gymha/util/util.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {

  bool isVisible1 = false;
  bool isVisible2 = false;
  bool isVisible3 = false;
  bool isVisible4 = false;

  @override
  Widget build(BuildContext context) {
    List<String> boxContent = [
      "assets/images/admin_tiles/page-1.jpeg",
      "assets/images/admin_tiles/page-2.jpeg",
      "assets/images/admin_tiles/page-3.jpeg",
      "assets/images/admin_tiles/page-4.jpeg"
    ];

    return Scaffold(
      appBar: MyAppBar,
      backgroundColor: MyBcolor,
      body: Row(
        children: [
          //open Drawer
          MyDrawer,

          //Rest of the body
          Expanded(
            flex: 3,
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 4,
                    child: SizedBox(
                      width: double.infinity,
                      child: GridView.builder(
                          itemCount: 4,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                child: InkWell(
                                  splashColor: Colors.brown.withOpacity(0.7), // Splash color
                                  onTap: () {

                                    if(index == 0) {
                                      if (isVisible2 == true || isVisible3 == true || isVisible4 == true) {
                                        isVisible2 == false;
                                        isVisible3 == false;
                                        isVisible4 == false;
                                      }
                                      else {
                                        setState(() =>
                                        isVisible1 = !isVisible1);
                                      }
                                    }

                                    else if(index == 1){
                                      if (isVisible1 == true || isVisible3 == true || isVisible4 == true) {
                                        isVisible1 == false;
                                        isVisible3 == false;
                                        isVisible4 == false;
                                      }
                                      else {
                                        setState(() =>
                                        isVisible2 = !isVisible2);
                                      }
                                    }

                                    else if(index == 2){
                                      if (isVisible2 == true || isVisible1 == true || isVisible4 == true) {
                                        isVisible2 == false;
                                        isVisible1 == false;
                                        isVisible4 == false;
                                      }
                                      else {
                                        setState(() =>
                                        isVisible3 = !isVisible3);
                                      }
                                    }

                                    else if(index == 3){
                                      if (isVisible2 == true || isVisible3 == true || isVisible1 == true) {
                                        isVisible2 == false;
                                        isVisible3 == false;
                                        isVisible1 == false;
                                      }
                                      else {
                                        setState(() =>
                                        isVisible4 = !isVisible4);
                                      }
                                    }

                                  },
                                  child: Ink(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(boxContent[index]), // Background image
                                      ),
                                    ),
                                  ),
                                ),
                              ),



                            );

                              //MyBox(boxContent: boxContent[index], index: index);
                          }
                      ),
                    ),
                  ),


                ],
              ),
          ),

          Expanded(
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    //color: Colors.pinkAccent,
                   children:[
                     Visibility(
                     visible: isVisible1,
                     child: Column(
                       children: [
                         RedirectWidget(cardName: "VIEW USER ACCOUNTS", imgPath: "assets/images/logo-bg.png",
                             onTap: adminViewUsers),
                         RedirectWidget(cardName: "EDIT USER ACCOUNTS", imgPath: "assets/images/admin_tiles/usermanage.jpg",
                             onTap: adminEditUsers),
                         // RedirectWidget(cardName: "APPROVE COMPLETION", imgPath: "assets/images/admin_tiles/approve.jpg",
                         //     onTap: MyRoutes.openAdminBlog(context)),
                       ],
                     )
                   ),
                    //Courses options
                    Visibility(
                        visible: isVisible2,
                        child: Column(
                          children: [
                            // RedirectWidget(cardName: "CREATE COURSE", imgPath: "assets/images/admin_tiles/uploadcourse.jpg",
                            //     onTap: MyRoutes.openAdminBlog(context)),
                            // RedirectWidget(cardName: "EDIT/DELETE COURSE", imgPath: "assets/images/admin_tiles/editcourse.jpg",
                            //     onTap: adminEditUsers),
                            // RedirectWidget(cardName: "COURSE COMPLAINTS", imgPath: "assets/images/admin_tiles/feedback.jpg",
                            //     onTap: MyRoutes.openAdminBlog(context)),
                          ],
                        )
                    ),
                     //Blog options
                     Visibility(
                         visible: isVisible3,
                         child: Column(
                           children:const [
                             // RedirectWidget(cardName: "EVENTS", imgPath: "assets/images/admin_tiles/Events.jpg",
                             //     onTap:MyRoutes.openAdminBlog(context)),
                             RedirectWidget(cardName: "NEWSLETTER", imgPath: "assets/images/admin_tiles/newsletter.jpg",
                                 onTap: adminNewsletter),
                             RedirectWidget(cardName: "GALLERY", imgPath: "assets/images/admin_tiles/gallery.jpg",
                                 onTap: adminGallery),
                             // RedirectWidget(cardName: "COMMENTS", imgPath: "assets/images/admin_tiles/comment.jpg",
                             //   onTap: MyRoutes.openAdminBlog(context)),
                           ],
                         )
                     ),
                     //Counseling options
                     Visibility(
                         visible: isVisible4,
                         child: Column(
                           children: [
                             RedirectWidget(cardName: "COUNSELING", imgPath: "assets/images/admin_tiles/counseling.jpg",
                                 onTap: adminCounseling),
                           ],
                         )
                     ),
                    ]
                   // child:
                  ),
                ),
              )
          )

        ],
      ),

    );
  }
}
