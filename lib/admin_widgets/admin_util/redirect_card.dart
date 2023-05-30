
import 'dart:ui';

import 'package:flutter/material.dart';

class RedirectWidget extends StatelessWidget {
  const RedirectWidget({Key? key, required this.cardName, required this.imgPath, required this.onTap}) : super(key: key);

  final String cardName;
  final String imgPath;
  final String onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 51, right: 51),
      child: InkWell(
        onTap: () {Navigator.of(context).pushNamed(onTap);},
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade600.withOpacity(0.5),
                spreadRadius: 3.0,
                //blurRadius: 5.0
              )
            ],
            color: Colors.white
          ),
          child: Column(
            children: [
              Hero(
                  tag: imgPath,
                  child: Container(
                    height: 100,
                    width: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imgPath),
                          fit: BoxFit.fill
                      )
                    ),
                  )
              ),
              SizedBox(height: 7,),
              Text(cardName,
              textAlign: TextAlign.center,
              style:  TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),),
              SizedBox(height: 7,),
            ],
          ),
        ),
      )



    );
  }
}
