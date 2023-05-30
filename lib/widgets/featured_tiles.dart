import 'package:gymha/widgets/responsive.dart';
import 'package:flutter/material.dart';

class FeaturedTiles extends StatelessWidget {
  FeaturedTiles({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  final List<String> assets = [
    'assets/images/pic1.jpg',
    'assets/images/pic2.png',
    'assets/images/pic3.png',
    'assets/images/pic4.jpg',
    'assets/images/pic5.jpg',
  ];

  final List<String> title = ['Emotional Intelligence Course', 'Psychological First Aid Course', 'Workplace Youth Mental Health Course', 'Depression course', 'Holistic wellbeing course'];

  @override
  Widget build(BuildContext context) {
    return /*ResponsiveWidget.isSmallScreen(context)
        ? Padding(
      padding: EdgeInsets.only(top: screenSize.height / 50),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: screenSize.width / 15),
            ...Iterable<int>.generate(assets.length).map(
                  (int pageIndex) => Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenSize.width / 2.5,
                        width: screenSize.width / 1.5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.asset(
                            assets[pageIndex],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenSize.height / 70,
                        ),
                        child: Text(
                          title[pageIndex],
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: screenSize.width / 15),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        : */
      screenSize.width<800?Padding(
        padding: EdgeInsets.only(
          top: screenSize.height/40
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: screenSize.width/15,),
          ...Iterable<int>.generate(assets.length).map(
                (int pageIndex) => Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: screenSize.width/2.5,
                          width: screenSize.width/1.5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.asset(
                                assets[pageIndex],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(padding:
                        EdgeInsets.only(
                          top: screenSize.height/70
                        ),
                          child: Text(
                            title[pageIndex],
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold

                            ),
                          ),
                        )

                      ],
                    ),
                    SizedBox(width: screenSize.width/15,)
                  ],

                )
              )

            ],
          ),
        ),
      )
      :SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
        padding: EdgeInsets.only(
          top: screenSize.height * 0.06,
          left: screenSize.width / 15,
          right: screenSize.width / 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...Iterable<int>.generate(assets.length).map(
                  (int pageIndex) => Column(
                children: [
                  SizedBox(
                    height: screenSize.width / 6,
                    width: 400,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                assets[pageIndex],
                                // fit: BoxFit.cover,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 20,
                                spreadRadius: 5,
                                color:Colors.grey.withOpacity(0.3),
                              )
                            ]
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenSize.height / 70,
                    ),
                    child: Text(
                      title[pageIndex],
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    ),
      );
  }
}