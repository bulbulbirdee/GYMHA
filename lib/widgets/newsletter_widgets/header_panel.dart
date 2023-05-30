import 'package:flutter/material.dart';
import 'package:gymha/widgets/responsive.dart';

class HeaderPanel extends StatelessWidget {
  HeaderPanel({Key? key}) : super(key: key);

  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    isMobile = ResponsiveWidget.isSmallScreen(context)? true: false;
    double w = MediaQuery.of(context).size.width;

    Widget LeftSidePanel() => Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('GYMHA',
          style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontFamily: 'Cinzel',
              fontWeight: FontWeight.w800,
              letterSpacing: .5
          ),),

        isMobile? Spacer(flex: 1,): SizedBox(width: 50),
      ],
    );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: w/10, vertical: isMobile? 30:10
      ),
      child:  isMobile? Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [LeftSidePanel()],
      ):
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LeftSidePanel()
            ],
          )
    );



  }
}
