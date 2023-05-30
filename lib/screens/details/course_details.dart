import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gymha/data_provider/cart_data_provider.dart';
import 'package:gymha/model/course.dart';
import 'package:gymha/model/section.dart';
import 'package:gymha/screens/details/details_widget/favorite_option.dart';
import 'package:gymha/util/util.dart';
import 'package:gymha/widgets/bottom_bar.dart';
import 'package:readmore/readmore.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({Key? key, required this.course}) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {

    return Material(
        child: MediaQuery.of(context).size.width < 1200 ? smallScreen(context)
            : bigScreen(context)
      );
  }

  Widget smallScreen(BuildContext context) {
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
                              Navigator.pop(context);
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
                                child: Image.asset(course.thumbnailUrl)),
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
                                course.title,
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
                                  Text(course.createdBy, style: const TextStyle(fontSize: 16, color: Color(0xFFff02fd),))

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
                                  Text('${course.lessonNo} Lessons', style: greyTextStyle,)
                                ],
                              ),
                              const SizedBox(width: 20,),
                              Row(
                                children: [
                                  const Icon(Icons.access_time),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(course.duration, style: greyTextStyle,)
                                ],
                              ),

                            ],
                          ),
                          const SizedBox(height: 10,),
                          ReadMoreText(
                          course.description,
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
                              Text( "5 Sections",
                              //  "${course.sections.length} Sections",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade700
                                ),
                              )
                            ],
                          ),
                          //
                          // UNCOMMENT THIS
                          // ListView.builder(
                          //     shrinkWrap: true,
                          //     itemCount: 5,
                          //     //course.sections.length,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     itemBuilder: (context, index) {
                          //       return buildCourseContent(index);
                          //     }
                          //     )


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
                  Text('\$${course.price}',
                  style: TextStyle(fontSize: 30, color: Colors.grey.shade900),),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                            onPressed: (){
                              String message = "Course is already added in the cart";
                              if(!CartDataProvider.cartCourseList.contains(course)){
                                message = "Course is added in the cart";
                                CartDataProvider.addCourse(course);
                              }

                              Fluttertoast.showToast(
                                  msg: message,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                  webPosition: "center",
                                  fontSize: 16.0,
                                  webBgColor: "linear-gradient(to right, #ff02fd, #11998e)"
                              );

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
        )
      ],
    );
  }

  // UNCOMMENT THIS

  //method to build course content
// Widget buildCourseContent(int index)
// {
//   Section section = course.sections[index];
//   return Container(
//     color: Colors.grey.shade300,
//     child: ExpansionTile(
//         title: Text("Section ${index + 1} - ${section.name}",
//         style: const TextStyle(fontSize:  18, fontWeight: FontWeight.bold),),
//       children: section.lectures.map((lecture){
//         return Container(
//           color: Colors.white,
//           child: ListTile(
//             dense: true,
//             onTap: (){},
//             leading: const SizedBox(),
//             title: Text(lecture.name),
//             subtitle: Row(
//               children: [
//                 const Icon(Icons.access_time, size: 15),
//                 const SizedBox(width: 10,),
//                 Text(lecture.duration, style: TextStyle(color: Colors.grey.shade500, fontSize: 15),)
//               ],
//             ),
//           ),
//         );
//       }
//       ).toList(),
//     ),
//   );
// }

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
                                child: Image.asset(course.thumbnailUrl, width: 600, height: 600,)),
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
                                  Text(course.duration, style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          course.title,
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
                                Text(course.createdBy, style: const TextStyle(fontSize: 16, color: Colors.white,))

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
                                Text('${course.lessonNo} Lessons', style: TextStyle(color: Colors.white),)
                              ],
                            ),
                        SizedBox(height: 30,),
                        Container(
                          width: 470,
                          child: Row(
                            children:  [
                              Expanded(
                                child: Text(
                                  course.description,
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
                      Text("5 SECTIONS",
                        //"${course.sections.length} Sections",
                        style: TextStyle(
                            fontSize: 14, color: Colors.white54
                        ),
                      )
                    ],
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
                          Text('\$${course.price}',
                            style: TextStyle(fontSize: 30, color: Colors.grey.shade900),),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: ElevatedButton(
                                    onPressed: (){
                                      String message = "Course is already added in the cart";
                                      if(!CartDataProvider.cartCourseList.contains(course)){
                                        message = "Course is added in the cart";
                                        CartDataProvider.addCourse(course);
                                      }

                                      Fluttertoast.showToast(
                                          msg: message,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          textColor: Colors.white,
                                          webPosition: "center",
                                          fontSize: 16.0,
                                          webBgColor: "linear-gradient(to right, #ff02fd, #11998e)"
                                      );

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


