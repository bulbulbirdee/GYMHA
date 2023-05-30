import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymha/admin_widgets/admin_edit_users.dart';
import 'package:gymha/widgets/responsive.dart';

class ViewUserPanel extends StatelessWidget {
  ViewUserPanel({Key? key, this.snap}) : super(key: key);

  final snap;
  String? downloadURL;

  bool isMobile = false;
  bool isDesktop = false;

  @override
  Widget build(BuildContext context) {

    //Show Alert dialog
    Future<void> _showAlertDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog( // <-- SEE HERE
            title: const Text('Delete user'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Are you sure want to Delete this User?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }



    isMobile = ResponsiveWidget.isSmallScreen(context)? true : false;
    isDesktop = ResponsiveWidget.isLargeScreen(context)? true : false;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: isMobile ? 0 : width/10,
        vertical: 8),
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
        child:
        // isMobile? BlogTileMobile(width, height, snap) :
        BlogTileDesktop(width, height, snap)
    );
  }

  Widget BlogTileDesktop(double w, double h, final snap) {


    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                snap['profilepic'] == null? Image.asset('assets/images/auth_file/profile pic default.jpg', width: w/6, height: h/6,)
               :Image.network(snap['profilepic'], width: w/6, height: h/6,),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Text("Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black54), ),
                      Text(snap['Name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34, color: Colors.purple),),
                      SizedBox(height: 10,),
                      Text("Email", style: TextStyle(fontSize: 14, color: Colors.black54), ),
                      Text(snap['Email'], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                      SizedBox(height: 5,),
                      Text("Phone number:", style: TextStyle(fontSize: 14, color: Colors.black54), ),
                      Text(snap['Phone'], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                      SizedBox(height: 5,),
                      Text("Address", style: TextStyle(fontSize: 14, color: Colors.black54), ),
                      Text(snap['Address'], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),)
                    ],
                  ),
                )),
                IconButton(
                    onPressed: () => Get.to(AdminEditUsers()),
                    icon: Icon(Icons.edit, color: Colors.purple,), )
              ],
            ),
          ),
        ],
      ),
    );
  }


  // Future<void> downloadURLExample() async {
  //   downloadURL = await FirebaseStorage.instance
  //       .ref()
  //       .child(snap['imageName'])
  //       .getDownloadURL();
  //   debugPrint(downloadURL.toString());
  // }

    // Future getImage() async{
    //   try{
    //     await downloadURLExample();
    //     return downloadURL;
    //   }catch(e){
    //     debugPrint('Error - $e');
    //     return null;
    //   }
    // }
}



