import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymha/admin_widgets/admin_dashboard_components/anime_holder.dart';
import 'package:gymha/admin_widgets/admin_dashboard_components/top_info_card.dart';
import 'package:gymha/widgets/responsive.dart';

class AppInfoBanner extends StatelessWidget {
  const AppInfoBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future<AggregateQuerySnapshot> count = FirebaseFirestore.instance.collection("Users").count().get();
    int docCount = 0;
    return Expanded(
        flex: 7,
        child: SingleChildScrollView(
            child: ResponsiveWidget.isLargeScreen(context)?
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
             // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    // Center(
                    //   child:
                      FutureBuilder<AggregateQuerySnapshot>(
                        future: count,
                        builder: (context, snapshot){
                          if(snapshot.hasError){
                            print("Error");
                          }
                          if(snapshot.hasData){
                            docCount = snapshot.data!.count;
                            top_info_card(fig: docCount, title: "USERS",);
                            top_info_card(fig: 74, title: "NEWSLETTERS");
                            top_info_card(fig: 43, title: "COUNSELLING REQUESTS");
                            print(docCount);
                          }
                          return CircularProgressIndicator();
                          }),

                  //  top_info_card(fig: DashboardInfo(), title: "USERS",),
                  //   top_info_card(fig: 74, title: "NEWSLETTERS"),
                  //   top_info_card(fig: 43, title: "COUNSELLING REQUESTS")
                  ],
                )
              ],
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width/1.2,),
                AnimeHolder(fig1: 2048, title1: 'USERS',fig2: 74, title2: 'NEWSLETTERS', fig3: 43, title3: 'COUNSELLING REQUESTS')

              ],
            )
        )
    );
  }

 //  int DashboardInfo(){
 //
 //    Future<AggregateQuerySnapshot> count = FirebaseFirestore.instance.collection("Users").count().get();
 //    int docCount = 0;
 //
 //    return FutureBuilder<AggregateQuerySnapshot>(
 //      future: count,
 //      builder: (context, snapshot){
 //        if(snapshot.hasError){
 //          print("Error");
 //        }
 //        if(snapshot.connectionState == ConnectionState.done){
 //          docCount = snapshot.data!.count;
 //          print(docCount);
 //        }
 //        return CircularProgressIndicator();
 //
 //      },
 //    );
 // //   return docCount;
 //  }
}