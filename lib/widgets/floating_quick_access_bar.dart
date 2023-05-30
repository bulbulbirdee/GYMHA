import 'package:flutter/material.dart';
import 'package:gymha/screens/user_side_screens/newsletter_screen.dart';
import 'package:gymha/screens/user_side_screens/user_gallery.dart';
import 'package:gymha/widgets/responsive.dart';

class FloatingQuickAccessBar extends StatefulWidget {
  const FloatingQuickAccessBar({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override

  _FloatingQuickAccessBarState createState() => _FloatingQuickAccessBarState();
}

class _FloatingQuickAccessBarState extends State<FloatingQuickAccessBar> {
  List _isHovering = [false, false, false, false];
  List<Widget> rowElements = [];

  List<String> items = ['About Us', 'Donate', 'Gallery', 'Newsletter'];
  List<IconData> icons = [
    Icons.dashboard,
    Icons.assistant,
    Icons.browse_gallery,
    Icons.contact_support_rounded
  ];



  List<Widget> generateRowElements() {
    rowElements.clear();
    for (int i = 0; i < items.length; i++) {
      Widget elementTile = InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onHover: (value) {
          setState(() {
            value ? _isHovering[i] = true : _isHovering[i] = false;
          });
        },
        onTap: () {
          if(i == 2){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserGallery()),
                );
              //  print("In the gallery");
              }
              else if(i == 3){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewsletterScreen()),
                );
              //  print("In the Newsletter");
              }
            },

        child: Text(
          items[i],
          style: TextStyle(
            color: _isHovering[i] ? Colors.black87 : Colors.white,
          ),
        ),
      );
      Widget spacer = SizedBox(
        height: widget.screenSize.height / 20,
        child: VerticalDivider(
          width: 1,
          color: Colors.blueGrey[100],
          thickness: 1,
        ),
      );
      rowElements.add(elementTile);
      if (i < items.length - 1) {
        rowElements.add(spacer);
      }
    }

    return rowElements;
  }

 @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1,
      child: Padding(
        padding: EdgeInsets.only(
          top: widget.screenSize.height * 0.60,
          left: ResponsiveWidget.isSmallScreen(context)
              ? widget.screenSize.width / 12
              : widget.screenSize.width / 5,
          right: ResponsiveWidget.isSmallScreen(context)
              ? widget.screenSize.width / 12
              : widget.screenSize.width / 5,
        ),
        child: widget.screenSize.width<800? Column(
          children: [
            for(int i=0; i<items.length; i++)
            Padding(
              padding: EdgeInsets.only(bottom: widget.screenSize.height/40 ),
              child: Card(
               // elevation: 4,
                color: Color(0x40c700c9),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: widget.screenSize.height/45,
                    bottom: widget.screenSize.height/45,
                    left: widget.screenSize.width/40,
                  ),
                  child: Row(
                    children:[
                      Icon(icons[i],
                      color: Colors.white),
                      SizedBox(width: widget.screenSize.width/50,),
                      InkWell(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onHover: (value) {
                          setState(() {
                            value ? _isHovering[i] = true : _isHovering[i] = false;
                          });
                        },
                        onTap: () {

                           if(i == 2){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const UserGallery()),
                                        );
                                      //  print("In the gallery");
                                      }
                                      else if(i == 3){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const NewsletterScreen()),
                                        );
                                      //  print("In the Newsletter");
                                      }
                                    },
                        child: Text(
                          items[i],
                          style: TextStyle(
                            color: _isHovering[i] ? Colors.black87 : Colors.white,
                          ),
                        ),
                      ),
                    ]


                  ),
                ),
              ),
            )
          ],

          )
        :Card(
          //elevation: 5,
          color: Color(0x33c700c9),
          child: Padding(
            padding: EdgeInsets.only(
              top: widget.screenSize.height/50,
              bottom: widget.screenSize.height/50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: generateRowElements(),
            ),
          ),
        ),
      ),
    );
  }
}