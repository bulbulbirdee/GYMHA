import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymha/admin_widgets/admin_course_dir/admin_course_lesson.dart';
import 'package:gymha/authentication/pallete.dart';
import 'package:gymha/widgets/responsive.dart';

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
            child: Text("Section List", style: TextStyle(
              color: Color(0xFFffafbd),
              fontSize: isMobile? 16: 20,
              fontWeight: FontWeight.w500,
            ),),
          ),
        ),
      ),

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

                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: TextFormField(
                         style: TextStyle(color: Colors.black87),
                         controller: controller,
                         decoration: const InputDecoration(
                             enabledBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: Colors.black87,
                                   width: 1,
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
                                   width: 2,
                                 )
                             )
                         ),
                       ),
                     ),

                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: ElevatedButton(onPressed: (){

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

                       }, child: Text("Submit")),
                     )
                   ],
                 ),
               ),
             );

           }
       );
     },
     child: Icon(Icons.add, color: Color(0xFFffafbd),),
      backgroundColor: Colors.white,),


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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: 30,),
            Container(
              width: w/3,
              padding: EdgeInsets.all(18),
              child: Text(courseData['title'], style:
                TextStyle(
                  color: Colors.white,
                  fontSize: isMobile?14:26,
                  fontWeight: FontWeight.bold
                ),)),
            Expanded(child: buildSectionListView(),)
          ],
        ),
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
                scrollDirection: Axis.vertical,
              itemCount: items.length,
                itemBuilder: (context, index){
                Map thisItem = items[index];
                return  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: Container(
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
                  child: ListTile(
                      title: Text(thisItem['section_title'].toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                      ),),
                      trailing: IconButton(icon: Icon(Icons.add),
                        onPressed: ()
                        { Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context)=>
                            AdminCourseLesson(thisItem, courseData))); },),
                    ),
                  ),
                );
                }
            );
          }
        return Center(child: CircularProgressIndicator());

      });
  }

}
