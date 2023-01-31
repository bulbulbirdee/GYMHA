import 'package:gymha/widgets/bottom_bar_column.dart';
import 'package:gymha/widgets/info_text.dart';
import 'package:gymha/widgets/responsive.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);
  static const Color gradientStartColor = Color(0xff11998e);
  static const Color gradientEndColor = Color(0xFFc700c9);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(0.0)),
        gradient: LinearGradient(
            colors: [
              gradientStartColor,
              gradientEndColor
            ],
            begin: const FractionalOffset(0.2, 0.2),
            end: const FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      padding: EdgeInsets.all(30),
      //color: Colors.blueGrey[900],
      child:
      MediaQuery.of(context).size.width<800?
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomBarColumn(
                    heading: 'ABOUT',
                    s1: 'Contact Us',
                    s2: 'Careers',
                    s3: 'Careers',
                  ),
                  BottomBarColumn(
                    heading: 'HELP',
                    s1: 'Payments',
                    s2: 'Cancellations',
                    s3: 'Careers',
                  ),
                  BottomBarColumn(
                    heading: 'SOCIAL',
                    s1: 'Twitter',
                    s2: 'Facebook',
                    s3: 'YouTube',
                  ),

                ],
              ),
              Divider(
                color: Colors.white60,
              ),
              SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoText(
                    type: 'Email',
                    text: 'Example@gmail.com',
                  ),
                  SizedBox(height: 5),
                  InfoText(
                    type: 'Address',
                    text: 'Address line 1',
                  )
                ],
              ),
              SizedBox(height: 10,),
              Divider(
                color: Colors.white60,
              ),
              Text(
                'Copyright © 2023 | GYMHA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              )
            ],
          )
      :Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomBarColumn(
                heading: 'ABOUT',
                s1: 'Contact Us',
                s2: 'Careers',
                s3: 'Careers',
              ),
              BottomBarColumn(
                heading: 'HELP',
                s1: 'Payments',
                s2: 'Cancellations',
                s3: 'Careers',
              ),
              BottomBarColumn(
                heading: 'SOCIAL',
                s1: 'Twitter',
                s2: 'Facebook',
                s3: 'YouTube',
              ),
              Container(
                color: Colors.white,
                width: 2,
                height: 150,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoText(
                    type: 'Email',
                    text: 'Example@gmail.com',
                  ),
                  SizedBox(height: 5),
                  InfoText(
                    type: 'Address',
                    text: 'Address line 1',
                  )
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.white,
          ),
          SizedBox(height: 20),
          Text(
            'Copyright © 2023 | GYMHA',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}