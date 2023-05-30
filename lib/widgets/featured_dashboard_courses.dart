//Widget for featured courses on the dashboard


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymha/data_provider/course_data_provider.dart';
import 'package:gymha/model/course.dart';
import 'package:gymha/widgets/course_item.dart';

class FeaturedCourses extends StatelessWidget {
  const FeaturedCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    // List<Course> featuredCourseList = [
    //   CourseDataProvider.courseList[0],
    //   CourseDataProvider.courseList[1],
    //   CourseDataProvider.courseList[2],
    //   CourseDataProvider.courseList[3],
    //   CourseDataProvider.courseList[4],
    //
    // ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("GYMHA Courses",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),),
          ],
        ),
        const SizedBox(height: 10,),
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Courses').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot)
            {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return SizedBox(
                height: 900,
                child:
                Padding(
                  padding:  EdgeInsets.only(bottom: height/30, right: width/30),
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(snapshot.data!.docs.length, (index)
                    {
                      return CourseItem(
                              snap: snapshot.data!.docs[index].data(),
                            );
                    },
                    ),
                  ),
                ),
              );


              //   ListView.builder(
              //   scrollDirection: Axis.vertical,
              //   shrinkWrap: true,
              //   itemCount: snapshot.data!.docs.length,
              //   itemBuilder: (context, index) => BlogPanel(
              //     snap: snapshot.data!.docs[index].data(),
              //   ),
              // );

            }
        )

       //  SizedBox(
       //   height: 900,
       //  child:
       // Padding(
       //   padding:  EdgeInsets.only(bottom: height/30, right: width/30),
       //   child: GridView.count(
       //     crossAxisCount: 3,
       //     children: List.generate(featuredCourseList.length, (index)
       //     {
       //       Course course = featuredCourseList[index];
       //       return CourseItem(course: course);
       //       },
       //     ),
       //   ),
       // ),
       //  ),
      ],
    );
  }
}
