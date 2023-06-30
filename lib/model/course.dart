import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymha/model/course_category.dart';
import 'package:gymha/model/section.dart';

class Course {
  final String? id;
  final String courseID;
  final String title;
  final String thumbnailUrl;
  final String description;
  final String createdBy;
  DateTime createdDate;
  // final double rate;
  // bool isFavorite;
  final String price;
  // final CourseCategory courseCategory;
  final String duration;
  final String lessonNo;
 // final bool? live;
  // final List<Section> sections;

  Course({
    this.id,
    required this.courseID,
    required this.title,
    required this.thumbnailUrl,
    required this.description,
    required this.createdBy,
    required this.createdDate,
    //this.rate,
    //this.isFavorite,
    //this.courseCategory,
    required this.price,
    required this.duration,
    required this.lessonNo,
   // this.live
    //this.sections
  } );

  // bool get _isFavorite => isFavorite;
  //
  // set _isFavorite(bool value)  async {
  //   isFavorite = value;


  toJson() {
    return{
      "id" : id,
      "courseID" : courseID,
      "title" : title,
      "thumbnailUrl" : thumbnailUrl,
      "description" : description,
      "createdBy" : createdBy,
      "createdDate" : createdDate,
      //this._rate,
      //this._isFavorite,
      //this._courseCategory,
      "price" : price,
      "duration"  : duration,
      "lessonNo" : lessonNo,
    };
  }


  factory Course.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return Course(
        id: document.id,
        courseID: data["courseID"],
        title: data["title"],
        thumbnailUrl: data["thumbnailUrl"],
        description : data["description"],
        createdBy : data["createdBy"],
        createdDate : data["createdDate" ],
        price : data["price"],
        duration : data["duration"],
        lessonNo : data["lessonNo"],
    );


  }


//   double get rate => rate;
//
//   String get createdDate => createdDate;
//
//   String get createdBy => createdBy;
//
//   String get description => description;
//
//   String get thumbnailUrl => thumbnailUrl;
//
//   String get title => title;
//
//   String get id => id;
//
//   CourseCategory get courseCategory => courseCategory;
//
//   double get price => price;
//
//   String get duration => duration;
//
//   int get lessonNo => lessonNo;
//
//   List<Section> get sections => sections;
 }
