import 'package:flutter/material.dart';
import 'package:gymha/screens/home_page.dart';

class TopBarOther extends StatefulWidget {

  final double opacity;

  TopBarOther(this.opacity);

  @override
  State<TopBarOther> createState() => _TopBarOtherState();
}

class _TopBarOtherState extends State<TopBarOther> {
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      color: Colors.white.withOpacity(widget.opacity),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: screenSize.width/24),
                  const Text(
                    'GYMHA ',
                    style: TextStyle(
                      color: Color(0xFFc700c9),
                      fontSize: 26,
                      fontFamily: 'Cinzel',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),

                  // SizedBox(width: screenSize.width / 15),
                  // InkWell(
                  //   onHover: (value) {
                  //     setState(() {
                  //       value
                  //           ? _isHovering[1] = true
                  //           : _isHovering[1] = false;
                  //     });
                  //   },
                  //   onTap: () {},
                  //   child: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       Text(
                  //         'About Us',
                  //         style: TextStyle(
                  //             color: _isHovering[1]
                  //                 ? Color(0xFF077bd7)
                  //                 : Color(0xFF077bd7),
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 16
                  //         ),
                  //       ),
                  //       SizedBox(height: 5),
                  //       Visibility(
                  //         maintainAnimation: true,
                  //         maintainState: true,
                  //         maintainSize: true,
                  //         visible: _isHovering[1],
                  //         child: Container(
                  //           height: 2,
                  //           width: 20,
                  //           color: Color(0xFF051441),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(width: screenSize.width / 2),
                  InkWell(
                    onHover: (value) {
                      setState(() {
                        value
                            ? _isHovering[2] = true
                            : _isHovering[2] = false;
                      });
                    },
                    onTap: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Home',
                          style: TextStyle(
                              color: _isHovering[2]
                                  ? Color(0xFFff02fd)
                                  : Color(0xFFc700c9),
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                        SizedBox(height: 5),
                        Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          maintainSize: true,
                          visible: _isHovering[2],
                          child: Container(
                            height: 2,
                            width: 20,
                            color: Color(0xFFff02fd),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: screenSize.width / 19),
                  InkWell(
                    onHover: (value) {
                      setState(() {
                        value
                            ? _isHovering[0] = true
                            : _isHovering[0] = false;
                      });
                    },
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomePage()));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //SizedBox(width: 375),
                        Text(
                          'My Profile',
                          style: TextStyle(
                              color: _isHovering[0]
                                  ? Color(0xFFff02fd)
                                  : Color(0xFFc700c9),
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                        SizedBox(height: 5),
                        Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          maintainSize: true,
                          visible: _isHovering[0],
                          child: Container(
                            height: 2,
                            width: 20,
                            color: Color(0xFFff02fd),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: screenSize.width / 19),
                  InkWell(
                    onHover: (value) {
                      setState(() {
                        value
                            ? _isHovering[3] = true
                            : _isHovering[3] = false;
                      });
                    },
                    onTap: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Notifications',
                          style: TextStyle(
                              color: _isHovering[3]
                                  ? Color(0xFFff02fd)
                                  : Color(0xFFc700c9),
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                        SizedBox(height: 5),
                        Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          maintainSize: true,
                          visible: _isHovering[3],
                          child: Container(
                            height: 2,
                            width: 20,
                            color: Color(0xFFff02fd),
                          ),
                        )
                      ],
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
