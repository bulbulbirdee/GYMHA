import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymha/admin_widgets/admin_models/admin_newsletter_model.dart';
import 'package:gymha/admin_widgets/admin_util/consts.dart';
import 'package:gymha/model/course.dart';
import 'package:gymha/model/user_model.dart';

class AdminCourseRepository extends GetxController{
  static AdminCourseRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createCourse(Course Course) async{
    await _db.collection("Courses").add(Course.toJson())
        .whenComplete(
          () => showAlert("Course created sucessfully"),
    ).then((value)
    {
      String docid = value.id;
     // print(docid) ;
     // return docid;
    })
        .catchError((error, stackTrace){
      showAlert("Course not created");
      print(error.toString());
    });
  }

  //Fetch all users or user details
  // Future<NewsletterModel> getNewsletterDetails(String title) async{
  //   final snapshot = await _db.collection("Newsletters").where("title", isEqualTo: title).get();
  //   final NewsletterData = snapshot.docs.map((e) => NewsletterModel.fromSnapshot(e)).single;
  //   return NewsletterData;
  // }
  //
  // Future<List<NewsletterModel>> allNewsletter() async{
  //   final snapshot = await _db.collection("Newsletters").get();
  //   final NewsletterData = snapshot.docs.map((e) => NewsletterModel.fromSnapshot(e)).toList();
  //   return NewsletterData;
  // }
  //
  // Future<void> updateNewsletterRecord(NewsletterModel Newsletter) async{
  //   await _db.collection("Newsletters").doc(Newsletter.id).update(Newsletter.toJson());
  // }
}