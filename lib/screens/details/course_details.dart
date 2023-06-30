import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gymha/controllers/MenuController.dart';
import 'package:gymha/data_provider/cart_data_provider.dart';
import 'package:gymha/model/course.dart';
import 'package:gymha/model/section.dart';
import 'package:gymha/screens/details/details_widget/favorite_option.dart';
import 'package:gymha/screens/home_page.dart';
import 'package:gymha/screens/user_page.dart';
import 'package:gymha/util/util.dart';
import 'package:gymha/widgets/bottom_bar.dart';
import 'package:gymha/widgets/course_widgets/lesson_view.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class CourseDetails extends StatelessWidget {
  CourseDetails({Key? key, this.snap, this.courseID}) : super(key: key);

  final snap;
  final courseID;

  @override
  Widget build(BuildContext context) {

    return Material(
        child: MediaQuery.of(context).size.width < 1200 ? smallScreen(context)
            : bigScreen(context)
      );
  }

  Widget smallScreen(BuildContext context) {

    print(courseID);

    var greyTextStyle =  TextStyle(fontSize:  15, color: Colors.grey.shade600);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap:() {
                              if(FirebaseAuth.instance.currentUser! != null){
                                    Navigator.push(context, MaterialPageRoute(
                                    builder: (c) {
                                    var changeNotifierProvider = ChangeNotifierProvider(
                                    create: (context) => MenuController(),
                                    child: UserPage()
                                    );
                                    return changeNotifierProvider;
                                    },
                                    ),
                                    );
                              }
                              else
                                {
                                Navigator.push(context,MaterialPageRoute(builder: (context) =>
                                HomePage()),
                                );
                                }

                              },
                              child: const Icon(Icons.arrow_back, color: Colors.black87,)
                              ),
                              ),
                              Row(
                              children: [
                              Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.share, color: Colors.black87,),
                              ),
                              Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){
                                  Util.openShoppingCart(context);
                                },
                                  child: Icon(Icons.shopping_cart, color: Colors.black87,)
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                child: Image.network(snap["thumbnailUrl"])),
                        ])
                      ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                             snap["title"],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800),
                            ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //created by
                              Row(
                                children: [
                                  const Icon(Icons.person, color: Color(0xFFff02fd),),
                                  const SizedBox(width: 10,),
                                  Text(snap["createdBy"], style: const TextStyle(fontSize: 16, color: Color(0xFFff02fd),))

                                ],
                              ),
                              //Favorite icon
                             // FavoriteOption(course: course)
                            ],
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.play_circle_outline),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text('${snap["lessonNo"]} Lessons', style: greyTextStyle,)
                                ],
                              ),
                              const SizedBox(width: 20,),
                              Row(
                                children: [
                                  const Icon(Icons.access_time),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("${snap["duration"]} Weeks", style: greyTextStyle,)
                                ],
                              ),

                            ],
                          ),
                          const SizedBox(height: 10,),
                          ReadMoreText(
                            snap["description"],
                          trimLines: 1,
                          colorClickableText: Color(0xFFff02fd),
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Course Content",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20
                                ),
                              ),
                               Text( //"5 Sections",
                               "${snap["lessonNo"]} Sections",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade700
                                ),
                              ),
                            ],
                          ),

                          Column(
                            children:[
                              //Text(snap["id"]),
                               StreamBuilder(



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
                          //  ),
          ]
                          )
                         ],
                      ),
                    ),
                  )
                  ],
              ),
          ),
        ),




        Container(
          height: 60,
          margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$${snap["price"]}',
                  style: TextStyle(fontSize: 30, color: Colors.grey.shade900),),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                            onPressed: (){
                              String message = "Course is already added in the cart";
                              // if(!CartDataProvider.cartCourseList.contains(course)){
                              //   message = "Course is added in the cart";
                              //   CartDataProvider.addCourse(course);
                              },

                              // Fluttertoast.showToast(
                              //     msg: message,
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.CENTER,
                              //     timeInSecForIosWeb: 1,
                              //     textColor: Colors.white,
                              //     webPosition: "center",
                              //     fontSize: 16.0,
                              //     webBgColor: "linear-gradient(to right, #ff02fd, #11998e)"
                              // );

                         //   },
                          //  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFff02fd)),
                            child: const Text("Add to Cart", style: TextStyle(fontSize:  20),)
  ),
                      ),
                      ElevatedButton(
                          onPressed: (){
                            print("HEllo");
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFff02fd)),
                          child: const Text("Enroll Now", style: TextStyle(fontSize:  20),))
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  // UNCOMMENT THIS

  //method to build course content
Widget buildCourseContent(Map courseData, Map data, sectionId)
{
  
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
                               width: 30,
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

Widget bigScreen(BuildContext context) {
  var greyTextStyle =  TextStyle(fontSize:  15, color: Colors.grey.shade600);
    return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Color(0xFFc700c9)),
      elevation: 0,
      title: Text(
        'GYMHA ',
        style: TextStyle(
          color: Color(0xFFc700c9),
          fontSize: 26,
          fontFamily: 'Cinzel',
          fontWeight: FontWeight.w900,
          letterSpacing: 3,
        ),
      ),
    ),
      body:
      SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFFc700c9),
                    Color(0xFFff02fd)],
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children:[
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                child: Image.network(snap["thumbnailUrl"], width: 600, height: 600,)),
                          ])
                  ),
                    SizedBox(width: 20,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.share, color: Colors.black87, size: 30,),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: (){
                                    Util.openShoppingCart(context);
                                  },
                                  child: Icon(Icons.shopping_cart, color: Colors.black87, size: 30)
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 250),
                              child: Row(
                                children: [
                                  const Icon(Icons.access_time),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("${snap["duration"]} Weeks", style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          snap["title"],
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //created by
                            Row(
                              children: [
                                const Icon(Icons.person, color: Colors.white,),
                                const SizedBox(width: 10,),
                                Text(snap["createdBy"], style: const TextStyle(fontSize: 16, color: Colors.white,))

                              ],
                            ),
                            //Favorite icon
                            const SizedBox(width: 320,),
                        //    FavoriteOption(course: course)
                          ],
                        ),
                        SizedBox(height: 10,),
                            Row(
                              children: [
                                const Icon(Icons.play_circle_outline),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text('${snap["lessonNo"]} Lessons', style: TextStyle(color: Colors.white),)
                              ],
                            ),
                        SizedBox(height: 30,),
                        Container(
                          width: 470,
                          child: Row(
                            children:  [
                              Expanded(
                                child: Text(
                                  snap["description"],
                                  style: TextStyle(fontSize: 15, color: Colors.white),
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),

                  ]
                ),


                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Course Content",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 50, color: Colors.white
                        ),
                      ),
                      Text("${snap["lessonNo"]} Sections",
                        //"${course.sections.length} Sections",
                        style: TextStyle(
                            fontSize: 14, color: Colors.white54
                        ),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 270, vertical: 30),
                  child: Container(
                    width: 800,
                    color: Colors.white,
                    child: Column(
                        children:[
                          //Text(snap["id"]),
                          StreamBuilder(

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
                          //  ),
                        ]
                    ),
                  ),
                ),

               // UNCOMMENT THIS
               //  Padding(
               //  padding: const EdgeInsets.symmetric(horizontal: 270, vertical: 30),
               //   child:
               //    Container(
               //      width: 800,
               //      color: Colors.white,
               //      child:
               //      ListView.builder(
               //          shrinkWrap: true,
               //          //itemCount: course.sections.length,
               //          physics: const NeverScrollableScrollPhysics(),
               //          itemBuilder: (context, index) {
               //            return buildCourseContent(index);
               //          }),
               //    ),
               // ),

                Container(
                  height: 60,
                  margin: const EdgeInsets.only(left: 180, right: 180, bottom: 50),
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('\$${snap["price"]}',
                            style: TextStyle(fontSize: 30, color: Colors.grey.shade900),),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: ElevatedButton(
                                    onPressed: (){
                                      // String message = "Course is already added in the cart";
                                      // if(!CartDataProvider.cartCourseList.contains(course)){
                                      //   message = "Course is added in the cart";
                                      //   CartDataProvider.addCourse(course);
                                     // },

                                      // Fluttertoast.showToast(
                                      //     msg: message,
                                      //     toastLength: Toast.LENGTH_SHORT,
                                      //     gravity: ToastGravity.CENTER,
                                      //     timeInSecForIosWeb: 1,
                                      //     textColor: Colors.white,
                                      //     webPosition: "center",
                                      //     fontSize: 16.0,
                                      //     webBgColor: "linear-gradient(to right, #ff02fd, #11998e)"
                                      // );

                                    },
                                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFff02fd)),
                                    child: const Text("Add to Cart", style: TextStyle(fontSize:  20),)),
                              ),
                              ElevatedButton(
                                  onPressed: (){
                                    print("HEllo");
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFff02fd)),
                                  child: const Text("Enroll Now", style: TextStyle(fontSize:  20),))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                BottomBar()

              ],
            ),

      ),

      ),


  );
}


}


