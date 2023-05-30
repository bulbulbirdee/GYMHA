import 'package:flutter/material.dart';
import 'package:gymha/widgets/newsletter_widgets/panel_card.dart';
import 'package:gymha/widgets/responsive.dart';

class BodyPanel extends StatelessWidget {
  const BodyPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isMobile = ResponsiveWidget.isSmallScreen(context)? true: false;
    double w = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.fromLTRB(isMobile? 15: w/10, isMobile? 0: w/150, isMobile? 15: w/10, 10),
      child: Stack(children: [
        PanelCard(),
      ],),
    );
  }
}
