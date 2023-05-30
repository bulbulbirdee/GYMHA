import 'package:flutter/material.dart';
import 'package:gymha/widgets/responsive.dart';

class TopBackground extends StatelessWidget {
  const TopBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    
    
    return Container(
      width: w,
      height: ResponsiveWidget.isSmallScreen(context)? 300: 450,
      child: Image.asset("assets/images/gymha_logo_big.png", fit: BoxFit.cover,),
    );
  }
}
