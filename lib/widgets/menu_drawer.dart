import 'package:flutter/material.dart';
import 'package:gymha/authentication/login_page.dart';


class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    Key? key,
  }) : super(key: key);

  static const Color gradientStartColor = Color(0xff11998e);
  static const Color gradientEndColor = Color(0xFFc700c9);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  gradientStartColor,
                  gradientEndColor
                ],
                begin: const FractionalOffset(0.2, 0.2),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)
        ),
       // color: Color(0xff7b09eb),
        child: Padding(

          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginPage()));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                ),
                // InkWell(
                //   onTap: () {},
                //   child: Text(
                //     'Read',
                //     style: TextStyle(color: Colors.white, fontSize: 22),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                //   child: Divider(
                //     color: Colors.white,
                //     thickness: 2,
                //   ),
                // ),
                // InkWell(
                //   onTap: () {},
                //   child: Text(
                //     'Contact Us',
                //     style: TextStyle(color: Colors.white, fontSize: 22),
                //   ),
                // ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Copyright © 2023 | GYMHA',
                      style: TextStyle(
                        color: Colors.blueGrey.shade300,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}