import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymha/widgets/course_widgets/lesson_panel.dart';

class LessonView extends StatelessWidget {
  const LessonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    late Stream<QuerySnapshot> _streamLesson;

    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Courses')
              .doc("dLKhmoJxKlFBcVCEH8vK")
              .collection('Sections')
              .doc("N6AZN8WdXcqeLcF0eCw2")
              .collection('Lessons').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot)
          {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return
              // ListView.builder(
              // scrollDirection: Axis.vertical,
              // shrinkWrap: true,
              // itemCount: snapshot.data!.docs.length,
              // itemBuilder: (context, index) =>
                  LessonPanel(
                snap: snapshot.data!.docs[0].data(),
              );
          //  );

          }
      )
    );
  }
}
