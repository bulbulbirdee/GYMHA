import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymha/admin_widgets/admin_util/constant_routes.dart';

class Post extends StatelessWidget {
  const Post({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(Routes.newsletterDetail);
      },
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 160.h,
          width: 100.w,
          child: Column(
            children: [
              Container(
                height: 155.h,
                width: 330.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/pic1.jpg"),
                    fit: BoxFit.cover
                  )
                ),
              ),
              SizedBox(
                height: 10.h,
                ),
              
              Text(
                "Post Title",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
}
