import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gymha/admin_widgets/admin_models/admin_newsletter_model.dart';
import 'package:gymha/admin_widgets/admin_services/admin_course_repository.dart';
import 'package:gymha/admin_widgets/admin_services/admin_newsletter_repository.dart';
import 'package:gymha/model/course.dart';

class AdminCourseController extends GetxController{
  static AdminCourseController get instance => Get.find();

  //TextField controllers to get the data from the text fields
  final courseID = TextEditingController();
  final title = TextEditingController();
  final thumbnailUrl = TextEditingController() ;
  final description = TextEditingController() ;
  final createdBy = TextEditingController();
  final createdDate = TextEditingController();
  // final double rate;
  // bool isFavorite;
  final price = TextEditingController();
  // final CourseCategory courseCategory;
  final duration = TextEditingController();
  final lessonNo = TextEditingController();

  final CourseRepo = Get.put(AdminCourseRepository());

  Future<void> createCourse(Course course) async{
    await CourseRepo.createCourse(course);
    //final id = await createNewsletter(Newsletter).docid;

  }

// Get_Id(NewsletterModel Newsletter) async{
//   String? id = createNewsletter(Newsletter).docid;
// }

}