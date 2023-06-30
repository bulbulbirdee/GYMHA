import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboardInfo{

  int DashboardInfo(){

    Future<AggregateQuerySnapshot> count = FirebaseFirestore.instance.collection("Users").count().get();
    int docCount = 0;

    FutureBuilder<AggregateQuerySnapshot>(
      future: count,
      builder: (context, snapshot){
        if(snapshot.hasError){
          print("Error");
        }
        if(snapshot.connectionState == ConnectionState.done){
          docCount = snapshot.data!.count;
        }
        return CircularProgressIndicator();

      },
    );
    return docCount;
  }

}
