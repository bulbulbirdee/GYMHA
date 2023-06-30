import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymha/widgets/course_widgets/lesson_panel.dart';

class LessonView extends StatelessWidget {
   LessonView({Key? key, this.courseID, this.sectionID, this.lessonID}) : super(key: key);

  final courseID;
  final sectionID;
  final lessonID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('Courses')
            .doc(courseID)
            .collection('Sections')
            .doc(sectionID)
            .collection('Lessons').doc(lessonID).snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');

          if (snapshot.hasData) {
            print("Im here");
            return LessonPanel(snap: snapshot.data!.data());
          }

          return Center(child: CircularProgressIndicator());
        },
      )

      );
  }
}
