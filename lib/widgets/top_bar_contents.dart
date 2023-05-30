import 'package:flutter/material.dart';
import 'package:gymha/authentication/login_page.dart';

import 'package:gymha/authentication/signup_page.dart';

class TopBarContents extends StatefulWidget {
  final double opacity;

  TopBarContents(this.opacity);

  @override
  _TopBarContentsState createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
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
                    SizedBox(width: screenSize.width/21),
                    Text(
                      'GYMHA ',
                      style: TextStyle(
                        color: Color(0xFFc700c9),
                        fontSize: 26,
                        fontFamily: 'Cinzel',
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3,
                      ),
                    ),

                    SizedBox(width: screenSize.width / 2),
                    SizedBox(width: screenSize.width / 7),
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
                                LoginPage()));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Login',
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
                    SizedBox(width: screenSize.width / 20),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[3] = true
                              : _isHovering[3] = false;
                        });
                      },
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>SignUpPage()));
                      },
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Sign Up',
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