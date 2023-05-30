import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isMultiline;


  const ReusableTextField(
      {required this.hintText,
        required this.controller,
        required this.isMultiline,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMultiline ? 700 : 40,
      width: 500,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        maxLines: isMultiline ? null : 1,
        keyboardType: isMultiline ? TextInputType.multiline : null,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}