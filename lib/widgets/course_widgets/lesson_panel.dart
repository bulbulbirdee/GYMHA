import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymha/widgets/course_widgets/side_menu_lesson.dart';

class LessonPanel extends StatelessWidget {
  LessonPanel({Key? key, this.snap}) : super(key: key);

  final snap;
  String? downloadURL;

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar:
      // MediaQuery.of(context).size.width>1200?
      // PreferredSize(
      //   preferredSize: Size.fromHeight(75.0),
      //   child: AppBar(
      //     backgroundColor: Colors.white,
      //     elevation: 5,
      //     leading: Padding(
      //       padding: const EdgeInsets.all(15.0),
      //       child: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back, color: Color(0xFF4ca1af),)),
      //     ),
      //     title: Padding(
      //       padding: const EdgeInsets.only(top: 13.0),
      //       child: Text(snap!['lesson_title'], style: TextStyle(
      //         color: Color(0xFF4ca1af),
      //         fontSize: 20,
      //         fontWeight: FontWeight.w500,
      //       ),),
      //     ),
      //   ),
      // )
      //
      //     :
      AppBar(
        title: Text(snap!['lesson_title'], style: TextStyle(fontWeight: FontWeight.w500, color: Colors.green),),
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (context) =>
                IconButton(
                  onPressed: (){
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu, color: Colors.green,),),
          )
      ),
      drawer: SideMenuLesson(snap: snap,),
      body:
      SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xD94ca1af),
                  Color(0xD9c4e0e5)
                ],
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp
            ),
          ),
         // constraints: BoxConstraints(maxWidth: 1440 ),
          child:
          // Row(
          // //  mainAxisSize: MainAxisSize.min,
          //   children: [
              // if(MediaQuery.of(context).size.width>1200)
              //   Expanded(
              //     //fit: FlexFit.loose,
              //       flex: 2,
              //       child: SideMenuLesson(snap: snap,)
              //   ),
              SizedBox(
                //height: 1500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40,),
                          Center(
                            child: Container(
                            width: MediaQuery.of(context).size.width/2,
                            height: MediaQuery.of(context).size.width/4.4,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.green, spreadRadius: 3),
                            ],
                          ),
                            child: Image.network(snap!['lesson_image']),
                          ),
                          ),

                    SizedBox(height: 30,),

                    //BLOG BODY
                    Center(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.green, spreadRadius: 3),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width/1.25,
                          //height: MediaQuery.of(context).size.width/4.4,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(snap!['lesson_content'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'inter',
                                  ),),
                              ),
                            ],
                          )
                      ),
                    ),

                    SizedBox(height: 30,),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            // width: 200,
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () async {
                                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CourseListPage()));

                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                decoration: BoxDecoration(
                                  color:  Colors.green,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:  Row(
                                  children: [
                                    Icon(Icons.check, color: Colors.white,),
                                    SizedBox(width: 10,),
                                    Text(
                                      "Mark as Complete",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //   )
                            // ]


                          ),
                          SizedBox(width: 30,),
                          Container(
                           // width: 200,
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () async {
                                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CourseListPage()));

                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                decoration: BoxDecoration(
                                  color:  Colors.green,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:  Row(
                                  children: [
                                    Icon(Icons.arrow_forward, color: Colors.white,),
                                   SizedBox(width: 10,),
                                   // VerticalDivider(color: Colors.white, width: 2,),
                                    Text(
                                      "Next",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //   )
                            // ]


                          ),
                        ],
                      ),
                    ),

                  ],
                ),
            //   ),
            // ],
          ),
        ),
      ),
    );
  }
}
