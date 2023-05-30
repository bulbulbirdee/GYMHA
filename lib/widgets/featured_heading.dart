import 'package:gymha/widgets/responsive.dart';
import 'package:flutter/material.dart';

class FeaturedHeading extends StatelessWidget {
  const FeaturedHeading({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: screenSize.height * 0.06,
        left: screenSize.width / 15,
        right: screenSize.width / 15,
      ),
      child: screenSize.width<800?
      Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GYMHA Courses',
                style: TextStyle(
                    fontSize: 36,
                    fontFamily: 'Cinzel',
                    fontWeight: FontWeight.bold,
                    color:Color(0xFF5560a4)
                ),
              ),
              SizedBox(height: 5,),
              // Text(
              //   'Popular This Month',
              //   textAlign: TextAlign.end,
              // )
            ],

          ),

        ]


      ):
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'GYMHA Courses',
            style: TextStyle(
                fontSize: 36,
                fontFamily: 'Cinzel',
                fontWeight: FontWeight.bold,
                color:Color(0xFF5560a4)
            ),
          ),
          // Expanded(
          //   child: Text(
          //     'Popular This Month',
          //     textAlign: TextAlign.end,
          //   ),
          // ),
        ],
      ),
    );
  }
}