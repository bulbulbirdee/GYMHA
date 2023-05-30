import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymha/controllers/MenuController.dart';
import 'package:gymha/model/user_model.dart';
import 'package:gymha/widgets/responsive.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class UserHeader extends StatefulWidget {
  const UserHeader({Key? key}) : super(key: key);

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
  String username = '';
  String profilePic = '';

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  void getUserName() async{
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get();

   //print(snap.data());

    setState(() {
      username = (snap.data() as Map<String, dynamic>)!['Name'];
      profilePic = (snap.data() as Map<String, dynamic>)!['profilepic'];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (MediaQuery.of(context).size.width < 800)
          Text(
            "DASHBOARD",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            if (MediaQuery.of(context).size.width < 1200)
              IconButton(
                  onPressed: context.read<MenuController>().controlMenu,
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  )),
            if (MediaQuery.of(context).size.width > 800)
              Text(
                "DASHBOARD",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            if (MediaQuery.of(context).size.width > 800)
              Spacer(
                flex: MediaQuery.of(context).size.width > 1200 ? 2 : 1,
              ),
            Expanded(
                child: //SearchField()
                TextField(
                  decoration: InputDecoration(
                      hintText: "Search",
                      fillColor: Color(0xFFc700c9),
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(16 * 0.75),
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Icon(Icons.search),
                        ),
                      )),
                )
            ),
            //ProfileCard(),
            Container(
              margin: EdgeInsets.only(left: 16),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: Color(0xFFc700c9),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.white10)),
              child: Row(
                children: [
                   SizedBox(
                     width: 50,
                     height: 50,
                     child: ClipRRect(
                       borderRadius: BorderRadius.circular(100),
                       child: Image(
                        image: NetworkImage(
                            '$profilePic'),
                         loadingBuilder: (context, child, loadingProgress){
                           if(loadingProgress == null) return child;
                           return Center(child: CircularProgressIndicator());
                         },
                         errorBuilder:(context, object, stack){
                           return Container(
                               child: Icon(Icons.error_outline, color: Colors.black87,));
                         },
                         fit: BoxFit.cover,
                        //radius: 26,
                  ),
                     ),
                   ),
                  if (!(ResponsiveWidget.isSmallScreen(context)))
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '$username',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

// class ProfileCard extends StatefulWidget {
//   const ProfileCard({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(left: 16),
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//           color: Color(0xFFc700c9),
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//           border: Border.all(color: Colors.white10)),
//       child: Row(
//         children: [
//           const CircleAvatar(
//             backgroundImage: NetworkImage(
//                 'https://randomuser.me/api/portraits/women/44.jpg'),
//             radius: 26,
//           ),
//           if (!(ResponsiveWidget.isSmallScreen(context)))
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8),
//               child: Text(
//                 'User Name',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           const Icon(
//             (Icons.arrow_drop_down_outlined),
//             color: Colors.white,
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   State<StatefulWidget> createState() {
//     //  implement createState
//     throw UnimplementedError();
//   }
// }

class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Search",
          fillColor: Color(0xFFc700c9),
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(16 * 0.75),
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Icon(Icons.search),
            ),
          )),
    );
  }

  @override
  State<StatefulWidget> createState() {
    //  implement createState
    throw UnimplementedError();
  }
}
