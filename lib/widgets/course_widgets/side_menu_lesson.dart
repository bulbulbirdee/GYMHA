import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymha/widgets/course_widgets/lesson_view.dart';

class SideMenuLesson extends StatelessWidget {
  const SideMenuLesson({Key? key, this.snap}) : super(key: key);

  final snap;

  @override
  Widget build(BuildContext context) {

    String courseID = "dLKhmoJxKlFBcVCEH8vK";

    return Container(
      child: Column(
          children:[
            //Text(snap["id"]),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Courses')
                        .doc(courseID)
                        .collection('Sections')
                        .orderBy('created_on', descending: false)
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot)
                    {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if(snapshot.hasData){
                        //  print("Reached");
                        QuerySnapshot data = snapshot.data;
                        List<QueryDocumentSnapshot> documents = data.docs;
                        List<Map> items = documents.map((e) => {
                          'id':e.id,

                          'section_title' : e['section_title']}
                        ).toList();

                        //  print(items.length);

                        return ListView.builder(
                          //scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              Map thisItem = items[index];
                              return buildCourseContent(snap, thisItem, snapshot.data!.docs[index].reference.id.toString());
                            }
                        );
                      }

                      if(snapshot.hasError){Center(child: Text("Something is wrong"));}

                      return Center(child: CircularProgressIndicator());

                    }
                ),
              ),
            ),
            //  ),
          ]
      ),
    );
  }

  Widget buildCourseContent(Map courseData, Map data, sectionId)
  {

    String courseID = "dLKhmoJxKlFBcVCEH8vK";

    // print("We reached inside");

    late DocumentReference  _documentReference = FirebaseFirestore.instance.collection('Courses').doc(courseID).collection('Sections').doc(data['id']);

    late CollectionReference _referenceLesson = _documentReference.collection('Lessons');

    late Stream<QuerySnapshot> _streamLesson = _referenceLesson.orderBy('created_on', descending: false).snapshots();

    // Section section = course.sections[index];
    int secNo = 0;

    // print(data["id"]);

    return Container(
        color: Colors.grey.shade300,
        child: ExpansionTile(
            title: Text("${data["section_title"]}",
              style: const TextStyle(fontSize:  18, fontWeight: FontWeight.bold),),
            children:[
              StreamBuilder<QuerySnapshot>(
                  stream: _streamLesson,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
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
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index){
                            Map thisItem = items[index];
                            return Container(
                                color: Colors.white,
                                child: ListTile(
                                  dense: true,
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => LessonView(courseID: courseID, sectionID: sectionId, lessonID: snapshot.data!.docs[index].reference.id.toString() ,)),
                                    );

                                  },
                                  leading: const SizedBox(
                                   // width: 30,
                                    child: Icon(Icons.chrome_reader_mode_outlined),
                                  ),
                                  title: Text(thisItem['lesson_title']),
                                  // subtitle: Row(
                                  //   children: [
                                  //     const Icon(Icons.access_time, size: 15),
                                  //     const SizedBox(width: 10,),
                                  //     //Text("2 Mins", style: TextStyle(color: Colors.grey.shade500, fontSize: 15),)
                                  //   ],
                                  // ),
                                )
                            );
                          }
                      );
                    }
                    return Center(child: CircularProgressIndicator());

                  }
              )
            ]
        )
    );
  }
}
