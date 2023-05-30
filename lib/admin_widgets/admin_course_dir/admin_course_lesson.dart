import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:gymha/admin_widgets/admin_course_dir/lesson_builder.dart';
import 'package:gymha/authentication/pallete.dart';

class AdminCourseLesson extends StatelessWidget {
  AdminCourseLesson(this.data,this.courseData,{Key? key}) : super(key: key){

    _documentReference = FirebaseFirestore.instance.collection('Courses').doc(courseData['id']).collection('Sections').doc(data['id']);

    _referenceLesson = _documentReference.collection('Lessons');

    _streamLesson = _referenceLesson.orderBy('created_on', descending: false).snapshots();



  }
  Map courseData;
  Map data;

  late DocumentReference _documentReference;
  late CollectionReference _referenceLesson;
  late Stream<QuerySnapshot> _streamLesson;

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    TextEditingController controller = TextEditingController();

    final _formkey = GlobalKey<FormState>();

    String courseId = courseData['id'];
    String sectionID = data['id'];



    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context){

                TextEditingController controller = TextEditingController();
                return Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        SizedBox(height: 50,),

                        TextFormField(
                          style: TextStyle(color: Colors.black87),
                          controller: controller,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black87,
                                    width: 3,
                                  )
                              ),
                              label: Text("LESSON NAME", style: TextStyle(
                                  fontSize: 11
                              ),),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                  Icons.add,
                                  color: Colors.white
                              ),
                              labelStyle: TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black87,
                                    width: 3,
                                  )
                              )
                          ),
                        ),

                        ElevatedButton(onPressed: (){

                          //Get the data
                          Map<String, dynamic> lessonToAdd = {
                            'lesson_title' : controller.text,
                            'created_on' : FieldValue.serverTimestamp()
                          };

                          //Add the section
                          _referenceLesson.add(lessonToAdd);

                          //clear the field
                          _formkey.currentState?.reset();

                          //Dismiss the Bottom Sheet
                          Navigator.of(context).pop();

                        }, child: Text("Submit"))
                      ],
                    ),
                  ),
                );


              }
          );
       },
        child: Icon(Icons.add),),



     body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.black12,
            padding: EdgeInsets.all(18),
            child: Text(data['section_title']),
          ),
          Expanded(child: buildLessonListView(courseId, sectionID),)
        ],
      ),
    );
  }

  // Widget lessonBuilder(){
  //
  //   TextEditingController controller = TextEditingController();
  //
  //   final _formkey = GlobalKey<FormState>();
  //
  //         return Scaffold(
  //         //  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
  //           body: Form(
  //             key: _formkey,
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //
  //                 SizedBox(height: 50,),
  //
  //                 TextFormField(
  //                   style: TextStyle(color: Colors.black87),
  //                   controller: controller,
  //                   decoration: const InputDecoration(
  //                       enabledBorder: OutlineInputBorder(
  //                           borderSide: BorderSide(
  //                             color: Colors.black87,
  //                             width: 3,
  //                           )
  //                       ),
  //                       label: Text("LESSON NAME", style: TextStyle(
  //                           fontSize: 11
  //                       ),),
  //                       border: OutlineInputBorder(),
  //                       prefixIcon: Icon(
  //                           Icons.add,
  //                           color: Colors.white
  //                       ),
  //                       labelStyle: TextStyle(color: Colors.grey),
  //                       focusedBorder: OutlineInputBorder(
  //                           borderSide: BorderSide(
  //                             color: Colors.black87,
  //                             width: 3,
  //                           )
  //                       )
  //                   ),
  //                 ),
  //
  //                 ElevatedButton(onPressed: (){
  //
  //                   //Get the data
  //                   Map<String, dynamic> lessonToAdd = {
  //                     'lesson_title' : controller.text,
  //                     'created_on' : FieldValue.serverTimestamp()
  //                   };
  //
  //                   //Add the section
  //                   _referenceLesson.add(lessonToAdd);
  //
  //                   //clear the field
  //                   _formkey.currentState?.reset();
  //
  //                   //Dismiss the Bottom Sheet
  //                  // Navigator.of(context).pop();
  //
  //                 }, child: Text("Submit"))
  //               ],
  //             ),
  //           ),
  //         );
  //
  //       }

  Widget buildLessonListView(String courseId, sectionId){


    return StreamBuilder<QuerySnapshot>(
        stream: _streamLesson,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasError)
          {
            return Center(
              child: Text('some error has occured ${snapshot.error}'),
            );
          }
          if(snapshot.hasData)
          {
            QuerySnapshot data = snapshot.data;
            List<QueryDocumentSnapshot> documents = data.docs;
            List<Map> items = documents.map((e) => {
              'id':e.id,
              'lesson_title' : e['lesson_title']}).toList();

            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index){
                  Map thisItem = items[index];
                  return ListTile(
                    title: Text(thisItem['lesson_title'].toString()),
                    trailing: IconButton(icon: Icon(Icons.edit), onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdminLessonBuilder(thisItem['id'], thisItem['lesson_title'], courseId, sectionId )));

                    },),
                  );
                }
            );
          }
          return Center(child: CircularProgressIndicator());

        });
  }

}
