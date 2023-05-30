import 'package:flutter/material.dart';
import 'package:gymha/widgets/newsletter_widgets/profile_info.dart';
import 'package:gymha/widgets/responsive.dart';

class PanelCard extends StatelessWidget {
  const PanelCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Container(
      width:  w,
      margin: EdgeInsets.only(top: 180),
      padding: EdgeInsets.fromLTRB(10, ResponsiveWidget.isSmallScreen(context)? 80: 20, 10, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
          color: Colors.black.withOpacity(.1),
          blurRadius: 5,
          spreadRadius: 2
        )]),
      child: ProfileInfo(),
    );
  }
}
