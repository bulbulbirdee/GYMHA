import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymha/admin_widgets/admin_util/indicator.dart';
import 'package:gymha/authentication/login_page.dart';
import 'package:gymha/authentication/pallete.dart';
import 'package:gymha/controllers/MenuController.dart';
import 'package:gymha/controllers/sign_up_controller.dart';
import 'package:gymha/model/user_model.dart';
import 'package:gymha/screens/user_page.dart';
import 'package:gymha/services/auth_method.dart';
import 'package:gymha/services/user_repository.dart';
import 'package:gymha/widgets/responsive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {



  final controller = Get.put(SignUpController());
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;



  //Image initializations
  String selctFile = '';
  // late XFile file;
  late Uint8List selectedImageInBytes;
  // List<Uint8List> pickedImagesInBytes = [];
  List<String> imageUrls = [];
  int imageCounts = 0;
  bool isItemSaved = false;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    bool isMobile = ResponsiveWidget.isSmallScreen(context)? true : false;


    //This model is for image picking on desktop
    _selectFile(bool imageFrom) async {
      FilePickerResult? fileResult =
      await FilePicker.platform.pickFiles(allowMultiple: true);

      if (fileResult != null) {
        selctFile = fileResult.files.first.name;
        for (var element in fileResult.files) {
          setState(() {
            //pickedImagesInBytes.add(element.bytes!);
            selectedImageInBytes = fileResult.files.first.bytes!;
            imageCounts += 1;
          });
        }
      }
      print(selctFile);
    }

    //This model shows image selection either from gallery or camera
    void _showPicker(BuildContext context) {
      showModalBottomSheet(
        //backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Wrap(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                      leading: const Icon(
                        Icons.photo_library,
                      ),
                      title: const Text(
                        'Gallery',
                        style: TextStyle(),
                      ),
                      onTap: () {
                        _selectFile(true);
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(
                      Icons.photo_camera,
                    ),
                    title: const Text(
                      'Camera',
                      style: TextStyle(),
                    ),
                    onTap: () {
                      _selectFile(false);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    //To upload the image
    Future<String> _uploadFile() async {
      String imageUrl = '';
      try {
        firebase_storage.UploadTask uploadTask;

        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('Profile Images')
            .child('/' + selctFile);

        final metadata =
        firebase_storage.SettableMetadata(contentType: 'image/jpeg');

        //uploadTask = ref.putFile(File(file.path));
        uploadTask = ref.putData(selectedImageInBytes, metadata);

        await uploadTask.whenComplete(() => null);
        imageUrl = await ref.getDownloadURL();
      } catch (e) {
        print(e);
      }
      return imageUrl;
    }

    //To save the image in the firestore
    saveItem() async {
      if(selectedImageInBytes.isEmpty)
      {
        Fluttertoast.showToast(
            msg: "Please upload an image",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            webPosition: "center",
            fontSize: 16.0,
            webBgColor: "linear-gradient(to right, #ff02fd, #11998e)"
        );
      }
      else{
        setState(() {
          isItemSaved = true;
        });
        String imageUrl = await _uploadFile();
          setState(() {
            isItemSaved = false;
          });
          Fluttertoast.showToast(
              msg: "Images uploaded",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              webPosition: "center",
              fontSize: 16.0,
              webBgColor: "linear-gradient(to right, #ff02fd, #11998e)"
          );
        return imageUrl.toString();
       // });
      }
    }





    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
            child: Column(
                children: [
                  Image.asset('assets/images/signin_balls.png'),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Pallete.whiteColor,
                      fontSize: 50,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    'Create your profile to begin your journey...',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Pallete.whiteColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 50,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: w/3.5),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Profile Image

                      Center(
                        child: Stack(
                            children:[
                              selctFile.isEmpty
                                  ?CircleAvatar(
                            radius: 60, // Change this radius for the width of the circular border
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 58, // This radius is the radius of the picture in the circle avatar itself.
                              backgroundImage: AssetImage('assets/images/auth_file/profile pic default.jpg')
                            ),
                        )
                                  :CircleAvatar(
                                radius: 60, // Change this radius for the width of the circular border
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                    radius: 58,
                                  backgroundImage: MemoryImage(selectedImageInBytes),// This radius is the radius of the picture in the circle avatar itself.

                                ),
                              ),
                            Positioned(
                                bottom: 6,
                                right: 10,
                                child: InkWell(
                                  onTap: (){
                                    isMobile? _showPicker(context) : _selectFile(true);
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Pallete.gradient2,
                                    size: 28,
                                  ),
                                )
                            ),
                            ],
                        ),
                      ),

                          SizedBox(height: 30,),

                          //Name
                          TextFormField(
                            controller: controller.fullname,
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Pallete.borderColor,
                                      width: 3,
                                    )
                                ),
                                label: Text("Full Name", style: TextStyle(
                                    fontSize: 11
                                ),),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                    Icons.person_outline_rounded,
                                    color: Pallete.gradient2
                                ),
                                labelStyle: TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Pallete.gradient2,
                                      width: 3,
                                    )
                                )
                            ),
                          ),
                          SizedBox(height: 15,),
                          //Email
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: controller.email,
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Pallete.borderColor,
                                      width: 3,
                                    )
                                ),
                                label: Text("Email Address", style: TextStyle(
                                    fontSize: 11
                                ),),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Pallete.gradient2
                                ),
                                labelStyle: TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Pallete.gradient2,
                                      width: 3,
                                    )
                                )
                            ),
                          ),
                          SizedBox(height: 15,),
                          //Country
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: controller.country,
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Pallete.borderColor,
                                      width: 3,
                                    )
                                ),
                                label: Text("Country", style: TextStyle(
                                    fontSize: 11
                                ),),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                    LineAwesomeIcons.globe,
                                    color: Pallete.gradient2
                                ),
                                labelStyle: TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Pallete.gradient2,
                                      width: 3,
                                    )
                                )
                            ),
                          ),
                          SizedBox(height: 15,),
                          //Address
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: controller.address,
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Pallete.borderColor,
                                      width: 3,
                                    )
                                ),
                                label: Text("Address", style: TextStyle(
                                    fontSize: 11
                                ),),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                    LineAwesomeIcons.address_book,
                                    color: Pallete.gradient2
                                ),
                                labelStyle: TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Pallete.gradient2,
                                      width: 3,
                                    )
                                )
                            ),
                          ),
                          SizedBox(height: 15,),
                          //Phone Number
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: controller.phone,
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Pallete.borderColor,
                                      width: 3,
                                    )
                                ),
                                label: Text("Phone Number", style: TextStyle(
                                    fontSize: 11
                                ),),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                    Icons.phone_android_outlined,
                                    color: Pallete.gradient2
                                ),
                                labelStyle: TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Pallete.gradient2,
                                      width: 3,
                                    )
                                )
                            ),
                          ),
                          SizedBox(height: 15,),
                          //Password
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: controller.password,
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Pallete.borderColor,
                                      width: 3,
                                    )
                                ),
                                label: Text("Create password", style: TextStyle(
                                    fontSize: 11
                                ),),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                    Icons.password_outlined,
                                    color: Pallete.gradient2
                                ),
                                labelStyle: TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Pallete.gradient2,
                                      width: 3,
                                    )
                                )
                            ),
                          ),
                          SizedBox(height: 25,),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration:  BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Pallete.gradient1,
                          Pallete.gradient2,
                          Pallete.gradient3
                        ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight
                        ),
                        borderRadius: BorderRadius.circular(7)
                    ),
                    child: ElevatedButton
                      (onPressed: () async {
                        // if(selectedImageInBytes == null){
                        //   print('No picture');
                        // }else{
                        //   print("Pic is there");
                        // }
                      if(_formkey.currentState!.validate()){

                        setState(() {
                          isLoading = true;
                        });

                        String? url = await saveItem();

                        // Indicator.showLoading();

                        //var accreg = await UserRepository.accountRegistered;

                        //if(UserRepository.createUser() == true)

                        // SignUpController.instance.registerUser(
                        //     controller.email.text.trim(),
                        //     controller.password.text.trim()
                        // );

                        // phone and email authentication

                        // final user = UserModel(
                        //   email: controller.email.text.trim(),
                        //   password: controller.password.text.trim(),
                        //   name: controller.fullname.text.trim(),
                        //   phoneNo: controller.phone.text.trim(),
                        //   country: controller.country.text.trim(),
                        //   address: controller.address.text.trim(),
                        //   profilepic: url.toString()
                        // );
                        // SignUpController.instance.createUser(user);

                       String res = await AuthMethods().signUpUser(
                            name: controller.fullname.text.trim(),
                            address: controller.address.text.trim(),
                            country: controller.country.text.trim(),
                            phoneNo: controller.phone.text.trim(),
                            email: controller.email.text.trim(),
                            password: controller.password.text.trim(),
                            profilepic: url.toString()
                        );

                        setState(() {
                          isLoading = false;
                        });

                       // Indicator.closeLoading();

                       if(res != 'success'){
                         Fluttertoast.showToast(
                             msg: res,
                             toastLength: Toast.LENGTH_SHORT,
                             gravity: ToastGravity.CENTER,
                             timeInSecForIosWeb: 1,
                             textColor: Colors.white,
                             webPosition: "center",
                             fontSize: 16.0,
                             webBgColor: "linear-gradient(to right, #ff02fd, #11998e)"
                         );

                       }
                       else{
                         Navigator.push(context, MaterialPageRoute(
                           builder: (c) {
                             var changeNotifierProvider = ChangeNotifierProvider(
                                 create: (context) => MenuController(),
                                 child: UserPage()
                             );
                             return changeNotifierProvider;
                           },
                         ),
                         );
                       }

                      }},
                   // },
                      child: isLoading? Center(child: CircularProgressIndicator(color: Pallete.whiteColor,),)
                      : const Text('SIGN UP',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(240, 55),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Column(
                    children: [
                      const Text("OR", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Pallete.whiteColor,
                      ),),
                      SizedBox(height: 20,),

                      // Sign up using socials

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Padding(
                      //                padding: const EdgeInsets.all(10.0),
                      //                child: ElevatedButton(
                      //                  onPressed: (){},
                      //                  style: ElevatedButton.styleFrom(
                      //                      backgroundColor: Colors.transparent,
                      //                      shadowColor: Colors.transparent
                      //                  ),
                      //                  child: CircleAvatar(
                      //                    radius: 30,
                      //                    backgroundColor: Pallete.backgroundColor,
                      //                    child: CircleAvatar(
                      //                      radius: 23,
                      //                      backgroundImage: AssetImage(
                      //                          "assets/images/auth_file/google.png"
                      //                      ),
                      //                    ),
                      //                  ),
                      //                ),
                      //              ),
                      //     Padding(
                      //       padding: const EdgeInsets.all(10.0),
                      //       child: ElevatedButton(
                      //         onPressed: (){
                      //         },
                      //         style: ElevatedButton.styleFrom(
                      //             backgroundColor: Colors.transparent,
                      //             shadowColor: Colors.transparent
                      //         ),
                      //         child: CircleAvatar(
                      //           radius: 30,
                      //           backgroundColor: Pallete.backgroundColor,
                      //           child: CircleAvatar(
                      //             radius: 23,
                      //             backgroundImage: AssetImage(
                      //                 "assets/images/auth_file/facebook.png"
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                    ],
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );},
                    child: RichText(text: const TextSpan(
                        text: "Already have an account?",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20
                        ),
                        children: [
                          TextSpan(
                              text: " LOGIN",
                              style: TextStyle(
                                  color: Pallete.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ))
                        ]
                    )
                    ),
                  ),
                  SizedBox(height: w*0.1,),
                  // RichText(text: TextSpan(
                  //   text: "Sign Up using one of the following methods",
                  //   style: TextStyle(
                  //       color: Colors.grey,
                  //       fontSize: 16
                  //   ),
                  // )
                  // ),
                  // SizedBox(height: 10,),
                  // Wrap(
                  //   children: List<Widget>.generate(
                  //       2,
                  //           (index){
                  //         return Padding(
                  //           padding: const EdgeInsets.all(10.0),
                  //           child: CircleAvatar(
                  //             radius: 30,
                  //             backgroundColor: Pallete.backgroundColor,
                  //             child: CircleAvatar(
                  //               radius: 23,
                  //               backgroundImage: AssetImage(
                  //                   "assets/images/auth_file/"+images[index]
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       }),
                  // )
                ])
        ),
      ),
    );
  }
}
