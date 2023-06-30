import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymha/screens/details/course_details.dart';
import 'package:gymha/widgets/course_item.dart';
import 'package:gymha/widgets/responsive.dart';
import 'package:flutter/material.dart';

class FeaturedTiles extends StatelessWidget {
  FeaturedTiles({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  final List<String> assets = [
    'assets/images/pic1.jpg',
    'assets/images/pic2.png',
    'assets/images/pic3.png',
    'assets/images/pic4.jpg',
    'assets/images/pic5.jpg',
  ];

  final List<String> title = ['Emotional Intelligence Course', 'Psychological First Aid Course', 'Workplace Youth Mental Health Course', 'Depression course', 'Holistic wellbeing course'];

  @override
  Widget build(BuildContext context) {
    return screenSize.width<800?Padding(
        padding: EdgeInsets.only(
          top: screenSize.height/40
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:
          Row(
            children: [
              SizedBox(width: screenSize.width/15,),

              SizedBox(
                height: screenSize.height/1.97,
                width: screenSize.width,
                child:
                StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Courses').snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot)
                    {

                      if(snapshot.connectionState == ConnectionState.active){
                        return SizedBox(
                          child:
                          ListView(
                            scrollDirection: Axis.horizontal,
                            children: List.generate(snapshot.data!.docs.length, (index)
                            {
                              final snap = snapshot.data!.docs[index].data();
                              return Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>
                                            CourseDetails(
                                              snap: snapshot.data!.docs[index].data(), courseID: snapshot.data!.docs[index].reference.id.toString(),
                                            )),
                                      );



                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: screenSize.width/2.5,
                                          width: screenSize.width/1.5,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5.0),
                                            child: Image.network(
                                              snap['thumbnailUrl'],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(padding:
                                        EdgeInsets.only(
                                            top: screenSize.height/70
                                        ),
                                          child: Text(
                                            snap['title'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.bold

                                            ),
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                  SizedBox(width: screenSize.width/15,)
                                ],

                              );
                            },
                            ),
                          ),
                          //  ),
                        );

                      }

                      return Center(child: CircularProgressIndicator());

                    }
                ),
              )
             ],
          ),
        ),
      )
      :SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
        padding: EdgeInsets.only(
          top: screenSize.height * 0.06,
          left: screenSize.width / 25,
          right: screenSize.width / 25,
        ),
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          //  SizedBox(width: screenSize.width/25,),

            SizedBox(
              height:screenSize.height/2.5,
              width: screenSize.width,
              child:
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Courses').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot)
                  {

                    if(snapshot.connectionState == ConnectionState.active){
                      return SizedBox(
                        child:
                        ListView(
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          children: List.generate(snapshot.data!.docs.length, (index)
                          {
                            final snap = snapshot.data!.docs[index].data();
                            return Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          CourseDetails(
                                            snap: snapshot.data!.docs[index].data(), courseID: snapshot.data!.docs[index].reference.id.toString(),
                                          )),
                                    );
                                    },
                                  child: Column(
                                    children: [
                                      SizedBox(
                                                height: screenSize.height/3.2,
                                                width:  screenSize.width/3.5,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20.0)),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(5.0),
                                                          child: Image.network(
                                                              snap['thumbnailUrl'],
                                                              fit: BoxFit.cover,
                                                            ),
                                                        ),
                                                        ))),
                                      Padding(padding:
                                      EdgeInsets.only(
                                          top: screenSize.height/70
                                      ),
                                        child: Text(
                                          snap['title'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.bold

                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                                SizedBox(width: screenSize.width/15,)
                              ],

                            );
                          },
                          ),
                        ),
                        //  ),
                      );

                    }

                    return Center(child: CircularProgressIndicator());

                  }
              ),
            )
          ],
        ),
    ),
      );
  }
}