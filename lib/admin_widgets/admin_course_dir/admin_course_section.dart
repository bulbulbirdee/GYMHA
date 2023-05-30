import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:gymha/admin_widgets/admin_course_dir/admin_course_lesson.dart';
import 'package:gymha/authentication/pallete.dart';

class AdminCourseSection extends StatelessWidget {
  AdminCourseSection(this.courseData,{Key? key}) : super(key: key){

    _documentReference = FirebaseFirestore.instance.collection('Courses').doc(courseData['id']);

    _referenceSection = _documentReference.collection('Sections');

    _streamSections = _referenceSection.orderBy('created_on', descending: false).snapshots();



  }
  Map courseData;

  late DocumentReference _documentReference;
  late CollectionReference _referenceSection;
  late Stream<QuerySnapshot> _streamSections;

  @override
  Widget build(BuildContext context) {


    final _formkey = GlobalKey<FormState>();

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
                           label: Text("SECTION NAME", style: TextStyle(
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
                       Map<String, dynamic> sectionToAdd = {
                         'section_title' : controller.text,
                         'created_on' : FieldValue.serverTimestamp()
                       };

                       //Add the section
                       _referenceSection.add(sectionToAdd);

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


      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.black12,
            padding: EdgeInsets.all(18),
            child: Text(courseData['title']),
          ),
          Expanded(child: buildSectionListView(),)
        ],
      ),
    );
  }

  Widget buildSectionListView(){
    return StreamBuilder<QuerySnapshot>(
      stream: _streamSections,
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
              'section_title' : e['section_title']}).toList();

            return ListView.builder(
              itemCount: items.length,
                itemBuilder: (context, index){
                Map thisItem = items[index];
                return ListTile(
                  title: Text(thisItem['section_title'].toString()),
                  trailing: IconButton(icon: Icon(Icons.add), onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdminCourseLesson(thisItem, courseData))); },),
                );
                }
            );
          }
        return Center(child: CircularProgressIndicator());

      });
  }

}
