import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymha/screens/home_page.dart';
import 'package:gymha/widgets/gallery_widgets/image_component.dart';
import 'package:gymha/widgets/responsive.dart';


class UserGallery extends StatefulWidget {
  const UserGallery({Key? key}) : super(key: key);

  @override
  State<UserGallery> createState() => _UserGalleryState();
}

class _UserGalleryState extends State<UserGallery> {



   List<String> _imageUrls = [];

  @override
  void initState() {

    super.initState();
  //   _getImages();
  //   getFirebaseImageFolder();
  // //  _scrollController.addListener(_scrollListener);
  }

  // Future<void> _getImages() async {
  //   List<String> imageUrls = await getImages();
  //   setState(() {
  //     _imageUrls = imageUrls;
  //     print(imageUrls.toString());
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    bool isMobile = ResponsiveWidget.isSmallScreen(context)? true : false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(onPressed: () =>  Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        ), icon: const Icon(Icons.arrow_back, color: Color(0xFFc700c9),)),
        title: Text("GALLERY", style: TextStyle(
          color: Color(0xFFc700c9),
          fontSize: 26,
          fontFamily: 'Cinzel',
          fontWeight: FontWeight.w900,
          letterSpacing: 3,
        ),),
      ),
      //body:
      body:Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFFddd6f3),
                Color(0xFFfaaca8)
              ],
              tileMode: TileMode.clamp),
        ),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Gallery').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot)
            {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Wrap(
                          children:[
                           // for i in
                            isMobile? ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) => ImageComponent(
                                snap: snapshot.data!.docs[index].data(),
                              ),
                            )
                                :GridView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) => ImageComponent(
                                snap: snapshot.data!.docs[index].data(),
                              ), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            )
                          ]
                      )
                    ],
                  ),
                ),
              );
            }
        ),
      )
    );
  }
}

