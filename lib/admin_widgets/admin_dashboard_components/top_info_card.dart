import 'package:flutter/material.dart';
import 'package:gymha/widgets/responsive.dart';
class top_info_card extends StatelessWidget {
  const top_info_card({
    Key? key,
     required this.fig, required this.title,
  }) : super(key: key);

  final String title;
  final int fig;

  @override
  Widget build(BuildContext context) {

    // final w =

    // return ResponsiveWidget.isSmallScreen(context)?
    //
    // Container(
    //   margin: EdgeInsets.only(bottom: 10, top: 25),
    //   height: 250,
    //   width: MediaQuery. of(context). size. width/1.5 ,
    //   padding:
    //   EdgeInsets.only(left: 20, right: 20, bottom: 20),
    //   child:
    //
    // Container(
    //     decoration: BoxDecoration(
    //         color: Color(0xFFFED7BF),
    //         borderRadius: BorderRadius.only(
    //           bottomLeft: Radius.circular(80),
    //         ),
    //         boxShadow:[ new BoxShadow(
    //             color: Color(0xFF363f93).withOpacity(0.3),
    //             offset: new Offset(-10, 0),
    //             blurRadius: 20,
    //             spreadRadius: 4
    //         )]
    //     ),
    //     padding: EdgeInsets.only(left: 32, top: 50, bottom: 50),
    //     child:Column(
    //       children: [
    //         AnimeHolder(fig:2048, title: 'Users',),
    //         AnimeHolder(fig:34, title: 'Newsletters',),
    //         AnimeHolder(fig:23, title: 'Counselling Requests',),
    //
    //       ],
    //     )
    // )
    // )
       // :
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 25),
      height: 200,
      padding:
      EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFFED7BF),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(80),
            ),
            boxShadow:[ new BoxShadow(
                color: Color(0xFF363f93).withOpacity(0.3),
                offset: new Offset(-10, 0),
                blurRadius: 20,
                spreadRadius: 4
            )]
        ),
        padding: EdgeInsets.only(left: 32, top: 50, bottom: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(fig.toString(),style: TextStyle(color: Color(0xFF183038), fontSize: 34),),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(title,style: TextStyle(color: Color(0xFF183038), fontSize: 16, fontWeight: FontWeight.bold),),
            )
          ],
        ),
      ),
    );
  }
}

