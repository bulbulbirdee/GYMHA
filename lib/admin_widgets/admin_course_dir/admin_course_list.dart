import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymha/admin_widgets/admin_controllers/admin_course_controller.dart';
import 'package:gymha/admin_widgets/admin_course_dir/admin_course_section.dart';
import 'package:gymha/admin_widgets/admin_course_dir/admin_courses.dart';

class CourseListPage extends StatelessWidget {
  CourseListPage({Key? key}) : super(key: key){

    _referenceCourse = FirebaseFirestore.instance.collection('Courses');
    _future=_referenceCourse.get();

  }
  late CollectionReference _referenceCourse;
  late Future<QuerySnapshot>_future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Courses'),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AdminCourses()));
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<QuerySnapshot>(
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
                itemCount: documents.length,
                itemBuilder: (context,index){
                  Map thisItem=items[index] as Map;
                  return ListTile(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdminCourseSection(thisItem)));
                    },
                    title: Text(thisItem['title']),);
                });
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}