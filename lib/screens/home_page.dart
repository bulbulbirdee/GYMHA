// import 'package:flutter_web/widgets/bottom_bar.dart';
// import 'package:flutter_web/widgets/carousel.dart';
// import 'package:flutter_web/widgets/featured_heading.dart';
// import 'package:flutter_web/widgets/featured_tiles.dart';

// import 'package:flutter_web/widgets/main_heading.dart';
// import 'package:flutter_web/widgets/menu_drawer.dart';

import 'package:flutter/material.dart';
import 'package:gymha/widgets/bottom_bar.dart';
import 'package:gymha/widgets/carousel.dart';
import 'package:gymha/widgets/floating_quick_access_bar.dart';
import 'package:gymha/widgets/main_heading.dart';
import 'package:gymha/widgets/menu_drawer.dart';
import 'package:gymha/widgets/top_bar_contents.dart';

import '../widgets/featured_heading.dart';
import '../widgets/featured_tiles.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: screenSize.width<800?AppBar(
        backgroundColor: Colors.white.withOpacity(_opacity),
        iconTheme: IconThemeData(color: Color(0xFFc700c9)),
        elevation: 0,
        title: Text(
          'GYMHA ',
          style: TextStyle(
            color: Color(0xFFc700c9),
            fontSize: 26,
            fontFamily: 'Cinzel',
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
          ),
        ),
      ): PreferredSize(
        preferredSize: Size(screenSize.width, 70),
        child: TopBarContents(_opacity),
      ),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  child: SizedBox(
                    height: screenSize.height * 0.44,
                    width: screenSize.width,
                    child: Image.asset(
                      'assets/images/logo-bg.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Column(
                  children: [
                    FloatingQuickAccessBar(screenSize: screenSize),
                    FeaturedHeading(screenSize: screenSize),
                    FeaturedTiles(screenSize: screenSize),
                    MainHeading(screenSize: screenSize),
                    MainCarousel(),
                    SizedBox(height: screenSize.height / 10,),
                    BottomBar()
                  ],
                )
              ],
            ),

          ],
        ),
      ),

    );
  }
}
