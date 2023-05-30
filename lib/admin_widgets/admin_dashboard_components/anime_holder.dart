import 'package:flutter/material.dart';

class AnimeHolder extends StatelessWidget {
  const AnimeHolder({
    Key? key,
    required this.fig1, required this.fig2, required this.fig3, required this.title1, required this.title2, required this.title3,
  }) : super(key: key);

  final int fig1, fig2, fig3;
  final String title1, title2, title3;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 25, right: 20),
      height: 220,
      padding:
      EdgeInsets.only(left: 20, right: 30, bottom: 20),
      child: Center(
        child: Container(
            decoration: BoxDecoration(
                color: Color(0xFFFED7BF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                ),
                boxShadow:[ new BoxShadow(
                    color: Color(0xFF363f93).withOpacity(0.3),
                    offset: new Offset(-10, 0),
                    blurRadius: 20,
                    spreadRadius: 4
                )]
            ),
            padding: EdgeInsets.only(left: 52, top: 50, bottom: 50, right: 30),
            child:Column(
              children: [
                Row(
                  children: [
                    TextAnimation(fig: fig1),
                    SizedBox(width: 10,),
                    Text("$title1", style: Theme.of(context).textTheme.subtitle2,),
                  ],
                ),

                Row(
                  children: [
                    TextAnimation(fig: fig2),
                    SizedBox(width: 10,),
                    Text("$title2", style: Theme.of(context).textTheme.subtitle2,),
                  ],
                ),

                Row(
                  children: [
                    TextAnimation(fig: fig3),
                    SizedBox(width: 10,),
                    Text("$title3", style: Theme.of(context).textTheme.subtitle2,),
                  ],
                )

              ],
            )
        ),
      ),
    );


  }
}

class TextAnimation extends StatelessWidget {
  const TextAnimation({
    Key? key,
    required this.fig,
  }) : super(key: key);

  final int fig;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: IntTween(begin: 0, end: fig),
        duration: Duration(seconds: 1),
        builder: (context, value, child) => Text("$value",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white70),
        ) );
  }
}