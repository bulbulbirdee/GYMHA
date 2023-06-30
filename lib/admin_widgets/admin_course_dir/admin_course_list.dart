import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymha/admin_widgets/admin_controllers/admin_course_controller.dart';
import 'package:gymha/admin_widgets/admin_course_dir/admin_course_section.dart';
import 'package:gymha/admin_widgets/admin_course_dir/admin_courses.dart';
import 'package:gymha/widgets/responsive.dart';

class CourseListPage extends StatelessWidget {
  CourseListPage({Key? key}) : super(key: key){

    _referenceCourse = FirebaseFirestore.instance.collection('Courses');
    _future=_referenceCourse.get();

  }
  late CollectionReference _referenceCourse;
  late Future<QuerySnapshot>_future;

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    bool isMobile = ResponsiveWidget.isSmallScreen(context)? true : false;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 5,
          leading: Padding(
            padding: const EdgeInsets.all(15.0),
            child: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back, color: Color(0xFFffafbd),)),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 13.0),
            child: Text("Course List", style: TextStyle(
              color: Color(0xFFffafbd),
              fontSize: isMobile? 16: 20,
              fontWeight: FontWeight.w500,
            ),),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AdminCourses()));
        },
        child: Icon(Icons.add, color: Color(0xFFffafbd),),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFffafbd),
            Color(0xFFffc3a0),
            // Color(0xFFd6c6fc)

          ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: SizedBox(

              width: w/3,
              child:
              // Padding(
              //   padding: const EdgeInsets.only(left: 350.0, right: 350.0, top: 50.0),
              //  child:
                FutureBuilder<QuerySnapshot>(
                  future: _future,
                  builder: (context,snapshot){
                    if(snapshot.hasError)
                    {
                      return Center(child: Text('Error:${snapshot.error}'));
                    }

                    if(snapshot.hasData)
                    {
                      QuerySnapshot data=snapshot.data!;
                      List<QueryDocumentSnapshot> documents=data.docs;
                      List<Map> items=documents.map((e) => {
                        'id':e.id,
                        'title':e['title']}).toList();

                      return ListView.builder(
                            scrollDirection: Axis.vertical,
                            //shrinkWrap: true,
                            itemCount: documents.length,
                            itemBuilder: (context,index){
                              Map thisItem=items[index] as Map;
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: const Offset(
                                          5.0,
                                          5.0,
                                        ),
                                        blurRadius: 10.0,
                                        spreadRadius: 2.0,
                                      ), //BoxShadow

                                    ]
                                ),
                                margin: EdgeInsets.only(bottom: 15),
                               // width: w/3,
                                child:
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child:
                                  ListTile(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdminCourseSection(thisItem)));
                                    },
                                    title: Text(thisItem['title'],
                                    style: TextStyle(
                                      color: Color(0xFFffafbd),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                    ),),),
                                ),
                              );
                            });
                    }

                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
          ),
        //  ),
        ),
      ),
    );
  }
}