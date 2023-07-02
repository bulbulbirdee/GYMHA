import 'package:flutter/material.dart';

import 'package:gymha/main.dart';
import 'package:gymha/model/course.dart';
import 'package:gymha/screens/details/course_details.dart';

class CourseItem extends StatelessWidget {
  CourseItem({Key? key, this.snap, this.courseID}) : super(key: key);

  final snap;
  final courseID;


  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: InkWell(
            onTap: (){
              // Details of course page
              // Navigator.pushNamed(context, MyApp.courseDetails,
              // arguments: CourseArgument(course));

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CourseDetails(snap: snap, courseID: courseID,)),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Image.network(snap["thumbnailUrl"]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (width<800)?Text(
                        snap["title"],
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold,color: Colors.blueGrey),
                      ):Text(
                        snap["title"],
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.blueGrey),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_outlined,
                                size: 20,
                                color: Color(0xFFff02fd),
                              ),
                              const SizedBox(width: 5,),
                              Text('${snap["duration"]} Weeks', style: TextStyle(fontSize: 15),)
                            ],
                          ),
                         // Text(courseID),
                          Text('\$${snap["price"]}', style: TextStyle(fontSize: 15, color: Colors.blueGrey, fontWeight: FontWeight.bold),)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
