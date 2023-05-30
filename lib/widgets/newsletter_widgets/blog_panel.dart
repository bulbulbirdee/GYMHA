import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gymha/widgets/responsive.dart';

class BlogPanel extends StatelessWidget {
  BlogPanel({Key? key, this.snap}) : super(key: key);

  final snap;
  String? downloadURL;

  bool isMobile = false;
  bool isDesktop = false;

  @override
  Widget build(BuildContext context) {
    isMobile = ResponsiveWidget.isSmallScreen(context)? true : false;
    isDesktop = ResponsiveWidget.isLargeScreen(context)? true : false;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 0 : width/10),
      padding: EdgeInsets.all(isMobile? 5: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isMobile? BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
            : BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2
          ),
        ],
      ),
      child: isMobile? BlogTileMobile(width, height, snap) : BlogTileDesktop(width, height, snap)
    );
  }

  Widget BlogTileDesktop(double w, double h, final snap){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(snap['imageName']),
                Expanded(child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snap['title'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),),
                      Text("By ${snap['writer']}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),)
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
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(snap['subtitle'],
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'inter',
                    fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(snap['content'],
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
    );
  }

  Widget BlogTileMobile(double w, double h, final snap){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child:
            Column(
              //mainAxisSize: MainAxisSize.max,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(snap['imageName']),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  child: Column(
                    //mainAxisSize: MainAxisSize.max,
                   // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snap['title'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: isMobile? 20: 34),),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("By ${snap['writer']}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: isMobile? 12: 16, fontStyle: FontStyle.italic),),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          //BLOG BODY
          Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(snap['subtitle'],
                      style: TextStyle(
                        fontSize: isMobile? 14: 18,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(snap['content'],
                      style: TextStyle(
                        fontSize: isMobile? 14: 18,
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
    );
  }

  Future<void> downloadURLExample() async{
    downloadURL = await FirebaseStorage.instance
        .ref()
        .child(snap['imageName'])
        .getDownloadURL();
    debugPrint(downloadURL.toString());

    Future getImage() async{
      try{
        await downloadURLExample();
        return downloadURL;
      }catch(e){
        debugPrint('Error - $e');
        return null;
      }
    }
  }
}
