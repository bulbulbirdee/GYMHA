import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class Indicator {
  static void showLoading() {
    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
  }

  static void closeLoading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

}