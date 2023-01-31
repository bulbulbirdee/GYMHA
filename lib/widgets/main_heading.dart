import 'package:gymha/widgets/responsive.dart';
import 'package:flutter/material.dart';

class MainHeading extends StatelessWidget {
  const MainHeading({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: screenSize.height / 10,
        bottom: screenSize.height / 15,
      ),
      width: screenSize.width,
      child: Text(
        'Global Youth Mental Health Awareness ',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 40,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}