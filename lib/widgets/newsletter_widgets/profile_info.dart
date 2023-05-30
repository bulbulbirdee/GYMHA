import 'package:flutter/material.dart';
import 'package:gymha/screens/home_page.dart';
import 'package:gymha/widgets/responsive.dart';

class ProfileInfo extends StatelessWidget {
  ProfileInfo({Key? key}) : super(key: key);

  String data = "Bringing you all the the latest happenings at GYMHA!";
  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    isMobile = ResponsiveWidget.isSmallScreen(context) ? true : false;
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Card header
        Container(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(flex: 1,),
              // SocialValue('Posts', 10),
              // SocialValue('Likes', 200),
              Spacer(flex: 10,),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  HomePage()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical:  5),
                  decoration:  BoxDecoration(
                    color:  Colors.teal[300],
                    borderRadius:  BorderRadius.circular(5),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('HOME', style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w700
                      ),)
                    ],
                  ),
                ),
              ),
              Spacer(flex: 1,)

            ],
          ),
        ),
        SizedBox(height: isMobile?20:50,),
        Text('NEWSLETTER', style: TextStyle(
          fontSize: isMobile?44 : 64,
          fontFamily: 'Oswald',
          fontWeight: FontWeight.w500,
          color: Colors.black87
        ),),
        SizedBox(height: 10,),
        Divider(height: 30, thickness: 1, color: Colors.grey[300],),
        Text(data, style: Theme.of(context).textTheme.bodyMedium,),
        SizedBox(height: 10,),

      ],),
    );
  }

  Widget SocialValue(String label, int value)=>
      Container(
        padding: EdgeInsets.all(5),
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$value',
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 12,
              fontWeight: FontWeight.bold
            ),),
            Text(label,
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 12,
              fontWeight: FontWeight.bold
            ),)
          ],
        ),
      );
}
