import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymha/authentication/pallete.dart';
import 'package:gymha/controllers/profile_controller.dart';
import 'package:gymha/model/user_model.dart';
import 'package:gymha/widgets/UserHeader.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final controller = Get.put(ProfileController());

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFFc700c9),
              )),
          title: Text(
            "EDIT PROFILE",
            style: TextStyle(
              color: Color(0xFFc700c9),
              fontSize: 24,
              fontFamily: 'Cinzel',
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Pallete.gradient1,
                    Pallete.gradient2,
                    Pallete.gradient3
                  ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                ),
                padding: EdgeInsets.all(30),
                child: Column(children: [
                  // Stack(children: [
                  //   SizedBox(
                  //     width: 120,
                  //     height: 120,
                  //     child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(100),
                  //       child: Image(
                  //         image: NetworkImage(
                  //             'https://randomuser.me/api/portraits/women/44.jpg',),
                  //         loadingBuilder: (context, child, loadingProgress){
                  //           if(loadingProgress == null) return child;
                  //           return Center(child: CircularProgressIndicator());
                  //         },
                  //         errorBuilder:(context, object, stack){
                  //           return Container(
                  //               child: Icon(Icons.error_outline, color: Colors.black87,));
                  //         },
                  //         ),
                  //       ),
                  //     ),
                  // //  ),
                  //   Positioned(
                  //     bottom: 0,
                  //     right: 0,
                  //     child: Container(
                  //       width: 35,
                  //       height: 35,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(100),
                  //         color: Colors.grey,
                  //       ),
                  //       child: const Icon(
                  //         LineAwesomeIcons.camera,
                  //         size: 20,
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //   )
                  // ]),
                  // const SizedBox(
                  //   height: 50,
                  // ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: w / 5),
                    child: Form(
                        child: FutureBuilder(
                            future: controller.getUserData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData)
                                {
                                  UserModel user = snapshot.data as UserModel;

                                  //Controllers
                                  final id =
                                      TextEditingController(text: user.id);
                                  final name =
                                      TextEditingController(text: user.name);
                                  final country =
                                      TextEditingController(text: user.country);
                                  final address =
                                      TextEditingController(text: user.address);
                                  final phoneno =
                                      TextEditingController(text: user.phoneNo);
                                  final profilepic =
                                      user.profilepic;

                                  return Column(
                                    children: [
                                      Stack(children: [
                                        SizedBox(
                                          width: 120,
                                          height: 120,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(100),
                                            child: Image(
                                              image: NetworkImage(
                                                '$profilepic',),
                                              loadingBuilder: (context, child, loadingProgress){
                                                if(loadingProgress == null) return child;
                                                return Center(child: CircularProgressIndicator());
                                              },
                                              errorBuilder:(context, object, stack){
                                                return Container(
                                                    child: Icon(Icons.error_outline, color: Colors.black87,));
                                              },
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        //  ),
                                        // Positioned(
                                        //   bottom: 0,
                                        //   right: 0,
                                        //   child: Container(
                                        //     width: 35,
                                        //     height: 35,
                                        //     decoration: BoxDecoration(
                                        //       borderRadius: BorderRadius.circular(100),
                                        //       color: Colors.grey,
                                        //     ),
                                        //     child: const Icon(
                                        //       LineAwesomeIcons.camera,
                                        //       size: 20,
                                        //       color: Colors.black,
                                        //     ),
                                        //   ),
                                        // )
                                      ]),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      TextFormField(
                                        //initialValue: user.name,
                                        controller: name,
                                        decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: Colors.black38,
                                              width: 2,
                                            )),
                                            label: Text(
                                              "Name",
                                              style: TextStyle(fontSize: 11),
                                            ),
                                            border: OutlineInputBorder(),
                                            prefixIcon: Icon(
                                                LineAwesomeIcons.user,
                                                color: Colors.white),
                                            labelStyle: TextStyle(
                                                color: Colors.black38),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 2,
                                            ))),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        // initialValue: user.country,
                                        controller: country,
                                        decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: Colors.black38,
                                              width: 2,
                                            )),
                                            label: Text(
                                              "Country",
                                              style: TextStyle(fontSize: 11),
                                            ),
                                            border: OutlineInputBorder(),
                                            prefixIcon: Icon(
                                                LineAwesomeIcons.globe,
                                                color: Colors.white),
                                            labelStyle: TextStyle(
                                                color: Colors.black38),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 2,
                                            ))),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        // initialValue: user.address,
                                        controller: address,
                                        decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: Colors.black38,
                                              width: 2,
                                            )),
                                            label: Text(
                                              "Address",
                                              style: TextStyle(fontSize: 11),
                                            ),
                                            border: OutlineInputBorder(),
                                            prefixIcon: Icon(
                                                LineAwesomeIcons.address_book,
                                                color: Colors.white),
                                            labelStyle: TextStyle(
                                                color: Colors.black38),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 2,
                                            ))),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        //initialValue: user.phoneNo,
                                        controller: phoneno,
                                        decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: Colors.black38,
                                              width: 2,
                                            )),
                                            label: Text(
                                              "Phone Number",
                                              style: TextStyle(fontSize: 11),
                                            ),
                                            border: OutlineInputBorder(),
                                            prefixIcon: Icon(
                                                LineAwesomeIcons.phone,
                                                color: Colors.white),
                                            labelStyle: TextStyle(
                                                color: Colors.black38),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 2,
                                            ))),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            final userData = UserModel(
                                              id: id.text,
                                              name: name.text.trim(),
                                              address: address.text.trim(),
                                              country: country.text.trim(),
                                              phoneNo: phoneno.text.trim(),
                                              email: user.email,
                                              password: user.password,
                                              profilepic: user.profilepic
                                            );

                                            await controller
                                                .updateRecord(userData);
                                          },
                                          child: const Text(
                                            'EDIT PROFILE',
                                            style: TextStyle(
                                              color: Color(0xFFc700c9),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size(240, 55),
                                              backgroundColor:
                                                  Colors.transparent,
                                              shadowColor: Colors.transparent),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // const Text.rich(TextSpan(
                                          //     text: "Joined: ",
                                          //     style: TextStyle(fontSize: 12),
                                          //     children: [
                                          //       TextSpan(
                                          //           text: "11 April 2023",
                                          //           style: TextStyle(
                                          //               fontWeight:
                                          //                   FontWeight.bold,
                                          //               fontSize: 12)),
                                          //     ])),
                                          ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .white
                                                      .withOpacity(0.2),
                                                  elevation: 0,
                                                  foregroundColor: Colors.red,
                                                  shape: const StadiumBorder(),
                                                  side: BorderSide.none),
                                              child: const Text("Delete"))
                                        ],
                                      )
                                    ],
                                  );
                                }
                                // {  return Center(child: Text("Here"),);}
                                else if (snapshot.hasError) {
                                  return Center(
                                      child: Text(snapshot.error.toString()));
                                } else {
                                  return const Center(
                                      child: Text("Something went wrong"));
                                }
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            })),
                  )
                ]))));
  }
}
