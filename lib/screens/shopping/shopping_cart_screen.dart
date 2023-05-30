import 'package:flutter/material.dart';
import 'package:gymha/data_provider/cart_data_provider.dart';
import 'package:gymha/widgets/top_bar_contents.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {

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

    //Method to calculate the price of the courses

    // double calculateTotal(){
    //   return CartDataProvider.cartCourseList.fold(0, (old, course) => old + course.price);
    // }

    double totalAmount = 10.0;
    //calculateTotal();

    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;


    return Scaffold(
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
        child: Container(
            color: Colors.white,
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
                              ]
                          )
                      )
                    ]
                )
            )
        ),
      ),
      //drawer: MenuDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Total Price:", style: TextStyle(fontSize:  20, color: Color(0xFFff02fd)),),
                    const SizedBox(width:  20,),
                    Text("\$$totalAmount", style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),)
                  ],
                ),
              )

            ],
          ),
        ),
      ),

    );


  }
}
