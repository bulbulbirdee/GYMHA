import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gymha/admin_widgets/admin_models/admin_newsletter_model.dart';
import 'package:gymha/admin_widgets/admin_services/admin_newsletter_repository.dart';

class AdminNewsletterController extends GetxController{
  static AdminNewsletterController get instance => Get.find();

  //TextField controllers to get the data from the text fields
  final title = TextEditingController();
  final writer = TextEditingController();
  final subtitle = TextEditingController();
  final content = TextEditingController();
  final imageName = TextEditingController();

  final NewsRepo = Get.put(AdminNewsletterRepository());

  Future<void> createNewsletter(NewsletterModel Newsletter) async{
    await NewsRepo.createNewsletter(Newsletter);
    //final id = await createNewsletter(Newsletter).docid;

  }

  // Get_Id(NewsletterModel Newsletter) async{
  //   String? id = createNewsletter(Newsletter).docid;
  // }

}