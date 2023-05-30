import 'package:flutter/material.dart';
import 'package:gymha/admin_widgets/constants.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {

    List<String> boxContent = [
      "assets/images/admin_tiles/page-1.jpeg",
      "assets/images/admin_tiles/page-2.jpeg",
      "assets/images/admin_tiles/page-3.jpeg",
      "assets/images/admin_tiles/page-4.jpeg"
    ];

    return Scaffold(
      appBar: MyAppBar,
      backgroundColor: MyBcolor,
      drawer: MyDrawer,
      body: Column(
        children: [
          // AspectRatio(
          //   aspectRatio: 1,
          //   child: SizedBox(
          //     width: double.infinity,
          //     child: GridView.builder(
          //       itemCount: 4,
          //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          //       itemBuilder: (context, index) {
          //         return MyBox(boxContent: boxContent[index], index: index);
          //       }
          //       ),
          //   ),
          // ),

          // Expanded(child: ListView.builder(
          //     itemCount: 5,
          //     itemBuilder: (context,index){
          //       return const MyTile();
          //     }
          //     )
       //   )
        ],
      ),
    );
  }
}
