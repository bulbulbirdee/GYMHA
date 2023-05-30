import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymha/admin_widgets/admin_models/admin_newsletter_model.dart';
import 'package:gymha/admin_widgets/admin_util/consts.dart';
import 'package:gymha/model/user_model.dart';

class AdminNewsletterRepository extends GetxController{
  static AdminNewsletterRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createNewsletter(NewsletterModel Newsletter) async{
    await _db.collection("Newsletters").add(Newsletter.toJson())
        .whenComplete(
          () => showAlert("Blog created sucessfully"),
    ).then((value)
            {String docid = value.id;
              return docid;
          })
        .catchError((error, stackTrace){
      showAlert("Blog not created");
      print(error.toString());
    });
  }

  //Fetch all users or user details
  Future<NewsletterModel> getNewsletterDetails(String title) async{
    final snapshot = await _db.collection("Newsletters").where("title", isEqualTo: title).get();
    final NewsletterData = snapshot.docs.map((e) => NewsletterModel.fromSnapshot(e)).single;
    return NewsletterData;
  }

  Future<List<NewsletterModel>> allNewsletter() async{
    final snapshot = await _db.collection("Newsletters").get();
    final NewsletterData = snapshot.docs.map((e) => NewsletterModel.fromSnapshot(e)).toList();
    return NewsletterData;
  }

  Future<void> updateNewsletterRecord(NewsletterModel Newsletter) async{
    await _db.collection("Newsletters").doc(Newsletter.id).update(Newsletter.toJson());
  }
}