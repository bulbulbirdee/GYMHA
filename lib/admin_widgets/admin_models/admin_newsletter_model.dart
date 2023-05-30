import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsletterModel{
  final String? id;
  final String title;
  final String writer;
  final String subtitle;
  final String content;
  final String? imageName;
  DateTime Datetime = DateTime.now();


   NewsletterModel(
      {
        this.id,
        required this.title,
        required this.writer,
        required this.subtitle,
        required this.content,
        this.imageName,
        required this.Datetime
      });

  toJson(){
    return{
      'title' : title,
      'writer': writer,
      'subtitle': subtitle,
      'content' : content,
      'imageName': imageName,
      'DateTime' : Datetime
    };
  }

  factory NewsletterModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return NewsletterModel(
        id: document.id,
        title: data["title"],
        writer: data["writer"],
        subtitle: data["subtitle"],
        content: data["content"],
        imageName: data["imageName"],
        Datetime: data['DateTime']
    );


  }
}