import 'package:flutter/material.dart';

class LessonPanel extends StatelessWidget {
  LessonPanel({Key? key, this.snap}) : super(key: key);

  final snap;
  String? downloadURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(snap['lesson_image']),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snap['lesson_title'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),),
                    //    Text("By ${snap['writer']}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),)
                      ],
                    ),
                  ))
                ],
              ),
            ),
            //BLOG BODY
            Container(
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(12.0),
                    //   child: Text(snap['subtitle'],
                    //     style: TextStyle(
                    //         fontSize: 20,
                    //         fontFamily: 'inter',
                    //         fontWeight: FontWeight.bold,
                    //         fontStyle: FontStyle.italic
                    //     ),),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(snap['lesson_content'],
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'inter',
                        ),),
                    ),
                  ],
                )
            ),

            //LIKE AND COMMENT
            Row(
              children: [
                IconButton(onPressed: (){},
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )),
                IconButton(onPressed: (){},
                    icon: const Icon(
                      Icons.comment_outlined  ,
                    ))
              ],
            ),

            InkWell(
              onTap: (){},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                child: Text('50 comments', style: TextStyle(fontSize: 14),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
