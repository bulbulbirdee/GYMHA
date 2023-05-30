import 'package:flutter/material.dart';

class LogoInfo extends StatelessWidget {
  const LogoInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/images/logo-bg.png', height: 200, width: 200,),
            Text("GYMHA", style: TextStyle(
              color: Color(0xFFc700c9),
              fontSize: 20,
              fontFamily: 'Cinzel',
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),),
          ],
        ),
      ),
    );
  }
}