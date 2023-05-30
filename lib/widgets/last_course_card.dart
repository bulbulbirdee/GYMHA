import 'package:flutter/material.dart';
import 'package:gymha/model/course.dart';

class LastCourseCard extends StatelessWidget {
  const LastCourseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final Course course;
//BRING THE COURSE INFORMATION OF THE USER TO GET THE LAST LEFT COURSE
    return Container(
      height: 230,
      child: Stack(
        children: [
          Positioned(
            top: 35,
              left: 20,
              child: Material(
            child: Container(
              height: height*0.3,
              width: width*0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0.0),
                boxShadow: [
                  BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  offset: new Offset(-10, 10),
                  blurRadius: 20,
                  spreadRadius: 4.0
                )]
              ),
            ),
          )),
          (width<800)?Positioned(
            top:0,
              child: Card(
                elevation: 10.0,
                shadowColor: Colors.grey.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Container(
                  height: 200,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/pic1.jpg"),
                    )
                  ),
                ),
              )
          ):Positioned(
              top:0,
              child: Card(
                elevation: 10.0,
                shadowColor: Colors.grey.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/pic1.jpg"),
                      )
                  ),
                ),
              )
          ),
          (width<800)?Positioned(
            top: 45,
              left: 270,
              child: Container(
                height: 150,
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Continue Course - ", style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFff02fd),
                      fontWeight: FontWeight.bold
                    ),),
                    Divider(
                      endIndent: 10,
                      color: Color(0xFFff02fd),
                    ),
                    SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Emotional Intelligence Course", style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold
                        ),),
                        Text("Section 3", style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFff02fd),

                        ),
                        child: Text("Go to course")),

                  ],
                ),
              )
          ):Positioned(
              top: 45,
              left: 330,
              child: Container(
                height: 150,
                width: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Continue Course", style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFff02fd),
                        fontWeight: FontWeight.bold
                    ),),
                    Divider(
                      color: Color(0xFFff02fd),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Emotional Intelligence Course", style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold
                          ),),
                          Text("Section 3", style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold
                          ),),
                          SizedBox(height: 20),
                          ElevatedButton(onPressed: (){},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFff02fd),

                              ),
                              child: Text("Go to course")),
                        ],
                      ),
                    ),


                  //],
                //),

                  ],
                ),
              )
          )
        ],
      ),

    );
  }
}
