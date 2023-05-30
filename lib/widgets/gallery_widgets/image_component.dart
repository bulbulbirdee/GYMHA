import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageComponent extends StatefulWidget {
  const ImageComponent({Key? key,this.snap}) : super(key: key);

  final snap;

  @override
  State<ImageComponent> createState() => _ImageComponentState();
}

class _ImageComponentState extends State<ImageComponent> {
  bool animate = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 45, vertical: 20),

      height: 600,
      width: 430,
      child: Stack(
        children: [
          Align(
            alignment: Alignment(0,0),
            child: Container(
              width: 600,
              height: 430,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.3)
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -1),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60)
              ),
              padding: EdgeInsets.all(10),
              child: Text(
                widget.snap['imageName']!,
                style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Color(0xFFf5f5f5),
                    fontWeight: FontWeight.w700
                ),
              ),

                //Description part,
            ),
          ),

          Align(
            alignment: Alignment(0,1),
            child: AnimatedOpacity(
              opacity: animate ? 1 :0,
              duration: Duration(milliseconds: 180),
              child: Container(
                margin: EdgeInsets.only(right: 10, left: 10, top:  80, bottom: 60),
               padding: EdgeInsets.symmetric(vertical: 35),
                child: Wrap(
                     children:[ Text(
                        widget.snap['imageDescription']!,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Color(0xFFf5f5f5),
                          fontWeight: FontWeight.w500
                        ),
                      ),]
                   ),
              ),

            ),
          ),
          MouseRegion(
            onEnter: (a) {
              setState(() {
                animate = true;
              });
            },
            onExit: (a){
              setState(() {
                animate = false;
              });
            },
            child: Align(
              alignment: Alignment.center,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 275),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                width: animate? 290: 600,
                height:  animate? 230 :430,
                //margin: EdgeInsets.all(30),
                child:  Image(image: NetworkImage(widget.snap['imageURL']!),
                fit: BoxFit.cover,),
              ),
            ),
          )
        ],
      ),
    );
  }
}
