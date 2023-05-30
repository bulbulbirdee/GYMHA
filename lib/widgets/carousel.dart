import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gymha/widgets/responsive.dart';
import 'package:flutter/material.dart';

class MainCarousel extends StatefulWidget {
  @override
  _MainCarouselState createState() => _MainCarouselState();
}

class _MainCarouselState extends State<MainCarousel> {
  final String imagePath = 'assets/images/';

  final CarouselController _controller = CarouselController();

  List _isHovering = [false, false, false, false, false, false, false];
  List _isSelected = [true, false, false, false, false, false, false];

  int _current = 0;

  final List<String> images = [
    'assets/images/car1.jpg',
    'assets/images/car2.jpg',
    'assets/images/car3.jpg',
  ];

  final List<String> places = [
    'OUR MISSION',
    'OUR RESPONSIBILITY',
    'OUR VISION',
  ];

  final List<String> content = [
    'Empower.\nEveryone , everywhere should have someone\nto turn to in support of their mental health',
    'To Initiate Ethical Responsibility As A Principle\nExample For The Future Of Others To Follow.',
    'To make psychology a household term.',
  ];

  List<Widget> generateImageTiles(screenSize) {
    return images
        .map(
          (element) => ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: ColorFiltered(
          colorFilter: const ColorFilter.mode(Color(0x80c700c9), BlendMode.color),
          child: Image.asset(
            element,
            fit: BoxFit.cover,
          ),
        ),
      ),
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var imageSliders = generateImageTiles(screenSize);

    return Stack(
      children: [
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
              enlargeCenterPage: true,
              aspectRatio: 18 / 8,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                  for (int i = 0; i < imageSliders.length; i++) {
                    if (i == index) {
                      _isSelected[i] = true;
                    } else {
                      _isSelected[i] = false;
                    }
                  }

                });
              }),
          carouselController: _controller,
        ),
        AspectRatio(
          aspectRatio: 18 / 8,
          child: Center(
            child: Text(
              content[_current],
              style: TextStyle(
                letterSpacing: 2,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: screenSize.width / 70,
                color: Colors.white,
              ),
            ),
          ),
        ),
        screenSize.width<800? Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < places.length; i++)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[i] = true
                              : _isHovering[i] = false;
                        });
                      },
                      onTap: () {
                        _controller.animateToPage(i);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: screenSize.height / 2.2,
                            bottom: screenSize.height / 90),
                        child: Text(
                          places[i],
                          style: TextStyle(
                            color: _isHovering[i]
                                ? Colors.blueGrey[900]
                                : Color(0xFF5560a4),
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Raleway'
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: _isSelected[i],
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 400),
                        opacity: _isSelected[i] ? 1 : 0,
                        child: Container(
                          height: 5,
                          decoration: BoxDecoration(
                            color: Color(0xFF5560a4),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          width: screenSize.width / 10,
                        ),
                      ),
                    )
                  ],
                ),
            ],
          ),
        )
            :Padding(
              padding: EdgeInsets.only(top: screenSize.height, left: screenSize.width/8, right: screenSize.width/8),
              child: Card(
                elevation: 5,
                color: Colors.grey.shade200,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < places.length; i++)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[i] = true
                                : _isHovering[i] = false;
                          });
                        },
                        onTap: () {
                          _controller.animateToPage(i);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                               top: screenSize.height / 30,
                               bottom: screenSize.height / 30),
                          child: Text(
                            places[i],
                            style: TextStyle(
                                color: _isHovering[i]
                                    ? Colors.blueGrey[900]
                                    : Color(0xFF5560a4),
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Raleway'
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: _isSelected[i],
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 400),
                          opacity: _isSelected[i] ? 1 : 0,
                          child: Container(
                            height: 5,
                            decoration: const BoxDecoration(
                              color: Color(0xFF5560a4),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            width: screenSize.width / 10,
                          ),
                        ),
                      )
                    ],
                  ),
              ],
          ),
        ),
            )
        // AspectRatio(
        //   aspectRatio: 17 / 8,
        //   child: Center(
        //     heightFactor: 1,
        //     child: Align(
        //       alignment: Alignment.bottomCenter,
        //       child: Padding(
        //         padding: EdgeInsets.only(
        //           left: screenSize.width / 8,
        //           right: screenSize.width / 8,
        //         ),
        //         child: Card(
        //           elevation: 5,
        //           child: Padding(
        //             padding: EdgeInsets.only(
        //               top: screenSize.height / 50,
        //               bottom: screenSize.height / 50,
        //             ),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //               children: [
        //                 for (int i = 0; i < places.length; i++)
        //                   Column(
        //                     mainAxisSize: MainAxisSize.min,
        //                     children: [
        //                       InkWell(
        //                         splashColor: Colors.transparent,
        //                         hoverColor: Colors.transparent,
        //                         onHover: (value) {
        //                           setState(() {
        //                             value
        //                                 ? _isHovering[i] = true
        //                                 : _isHovering[i] = false;
        //                           });
        //                         },
        //                         onTap: () {
        //                           _controller.animateToPage(i);
        //                         },
        //                         child: Padding(
        //                           padding: EdgeInsets.only(
        //                               top: screenSize.height / 80,
        //                               bottom: screenSize.height / 90),
        //                           child: Text(
        //                             places[i],
        //                             style: TextStyle(
        //                               color: _isHovering[i]
        //                                   ? Colors.blueGrey[900]
        //                                   : Color(0xFF5560a4),
        //                             ),
        //                           ),
        //                         ),
        //                       ),
        //                       Visibility(
        //                         maintainSize: true,
        //                         maintainAnimation: true,
        //                         maintainState: true,
        //                         visible: _isSelected[i],
        //                         child: AnimatedOpacity(
        //                           duration: Duration(milliseconds: 400),
        //                           opacity: _isSelected[i] ? 1 : 0,
        //                           child: Container(
        //                             height: 5,
        //                             decoration: const BoxDecoration(
        //                               color: Color(0xFF5560a4),
        //                               borderRadius: BorderRadius.all(
        //                                 Radius.circular(10),
        //                               ),
        //                             ),
        //                             width: screenSize.width / 10,
        //                           ),
        //                         ),
        //                       )
        //                     ],
        //                   ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}