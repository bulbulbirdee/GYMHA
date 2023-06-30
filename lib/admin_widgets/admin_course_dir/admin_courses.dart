import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymha/admin_widgets/admin_controllers/admin_course_controller.dart';
import 'package:gymha/admin_widgets/admin_controllers/admin_newsletter_controller.dart';
import 'package:gymha/admin_widgets/admin_course_dir/admin_course_list.dart';
import 'package:gymha/authentication/pallete.dart';
import 'package:gymha/model/course.dart';
import 'package:gymha/widgets/responsive.dart';

class AdminCourses extends StatefulWidget {
  const AdminCourses({Key? key}) : super(key: key);

  @override
  State<AdminCourses> createState() => _AdminCoursesState();
}

class _AdminCoursesState extends State<AdminCourses> {

  String selctFile = '';
  late Uint8List selectedImageInBytes;
  String imageUrl = '';
  int imageCounts = 0;
  bool isItemSaved = false;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }


  _selectFile(bool imageFrom) async {
    FilePickerResult? fileResult =
    await FilePicker.platform.pickFiles();

    if (fileResult != null) {
      setState(() {
        selctFile = fileResult.files.first.name;
        selectedImageInBytes = fileResult.files.first.bytes!;
      });
    }
    print(selctFile);
  }

  //To select files for mobile
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
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String> _uploadFile() async {
    String imageUrl = '';
    try {
      firabase_storage.UploadTask uploadTask;

      firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
          .ref()
          .child('Course Collection')
          .child('/' + selctFile);

      final metadata =
      firabase_storage.SettableMetadata(contentType: 'image/jpeg');

      //uploadTask = ref.putFile(File(file.path));
      uploadTask = ref.putData(selectedImageInBytes, metadata);

      await uploadTask.whenComplete(() => null);
      imageUrl = await ref.getDownloadURL();
    } catch (e) {
      print(e);
    }
    return imageUrl;
  }

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
      print('Uploaded Image URL ' + imageUrl.length.toString());

      // await FirebaseFirestore.instance.collection('Newsletters').doc().set({
      //   'imageName': imageUrl,
      // })
      //  .then((value) {
      setState(() {
        isItemSaved = false;
      });
      //print(id);
      Fluttertoast.showToast(
          msg: "Image uploaded",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          webPosition: "center",
          fontSize: 16.0,
          webBgColor: "linear-gradient(to right, #ff02fd, #11998e)"
      );
      return imageUrl.toString();
      //    });
    }
  }




  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    bool isMobile = ResponsiveWidget.isSmallScreen(context)? true : false;

    final controller = Get.put(AdminCourseController());
    final _formkey = GlobalKey<FormState>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 5,
          leading: Padding(
            padding: const EdgeInsets.all(15.0),
            child: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back, color: Color(0xFFffafbd),)),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 13.0),
            child: Text("Upload New Course", style: TextStyle(
              color: Color(0xFFffafbd),
              fontSize: isMobile? 16: 20,
              fontWeight: FontWeight.w500,
            ),),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFFffafbd),
              Color(0xFFffc3a0),
              // Color(0xFFd6c6fc)

            ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(

                width: w/1.28,
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text("Please refer to the instructions:\nAdmins can create courses on this page. Please enter the course details below. After filing, the details, please press the UPLOAD COURSE button. \nThe course structure would be uploaded and you will be directed to the next page where you can create the required lesson plan.",
                          style: TextStyle(
                              fontSize: 14,
                              //fontFamily: 'inter',
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),),
                      ),

                      const Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),

                      SizedBox(height: 30,),

                      // Text("Please refer to the instructions:\nAdmins can create courses on this page. Please enter the course details below. After filing, the details, please press the UPLOAD COURSE button. \nThe course structure would be uploaded and you will be directed to the next page where you can create the required lesson plan."),
                      // SizedBox(height: 10),
                      // Text("Enter the name of the course below"),


                      //IMAGE
                      Container(
                        height: h * 0.35,
                        width: w * 0.75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        child: selctFile.isEmpty
                            ? DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(20),
                            dashPattern: [10, 10],
                            color: Colors.grey,
                            strokeWidth: 2,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.cloud_upload, color: Colors.grey,),
                                        Text("Upload images")
                                      ]
                                  )),
                            )
                        )
                            :  Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration:
                                BoxDecoration(color: Colors.white),
                                child: Image.memory(selectedImageInBytes),
                              ),
                            ]
                        ),

                      ),
                      SizedBox(
                        height: h * 0.05,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: h * 0.05,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _showPicker(context);
                              // _selectFile(true);
                            },
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey)),
                            icon: const Icon(
                              Icons.camera,
                            ),
                            label: const Text(
                              'Pick Images',
                              style: TextStyle(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      if (isItemSaved)
                        Container(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),

                      SizedBox(height: 30,),

                      //Course ID
                      TextFormField(
                        style: TextStyle(color: Colors.black87),
                        controller: controller.courseID,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 1,
                                )
                            ),
                            label: Text("Course ID", style: TextStyle(
                                fontSize: 11
                            ),),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                                Icons.add,
                                color: Colors.grey
                            ),
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 3,
                                )
                            )
                        ),
                      ),

                      SizedBox(height: 30,),

                      //Title
                      TextFormField(
                        style: TextStyle(color: Colors.black87),
                        controller: controller.title,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 1,
                                )
                            ),
                            label: Text("Course Title", style: TextStyle(
                                fontSize: 11
                            ),),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                                Icons.title_outlined,
                                color: Colors.grey
                            ),
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 3,
                                )
                            )
                        ),
                      ),

                      SizedBox(height: 30,),

                      //Description
                      TextFormField(
                        style: TextStyle(color: Colors.black87),
                        controller: controller.description,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 1,
                                )
                            ),
                            label: Text("Course Description", style: TextStyle(
                                fontSize: 11
                            ),),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                                Icons.description,
                                color: Colors.grey
                            ),
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 3,
                                )
                            )
                        ),
                      ),

                      SizedBox(height: 30,),

                      //Created by
                      TextFormField(
                        style: TextStyle(color: Colors.black87),
                        controller: controller.createdBy,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 1,
                                )
                            ),
                            label: Text("Created by", style: TextStyle(
                                fontSize: 11
                            ),),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                                Icons.create,
                                color: Colors.grey
                            ),
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 3,
                                )
                            )
                        ),
                      ),

                      SizedBox(height: 30,),

                      // //Created Date
                      // TextFormField(
                      //   style: TextStyle(color: Colors.black87),
                      //   controller: controller.createdDate,
                      //   decoration: const InputDecoration(
                      //       enabledBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(
                      //             color: Colors.black87,
                      //             width: 3,
                      //           )
                      //       ),
                      //       label: Text("Created Date", style: TextStyle(
                      //           fontSize: 11
                      //       ),),
                      //       border: OutlineInputBorder(),
                      //       prefixIcon: Icon(
                      //           Icons.date_range,
                      //           color: Pallete.gradient2
                      //       ),
                      //       labelStyle: TextStyle(color: Colors.grey),
                      //       focusedBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(
                      //             color: Colors.black87,
                      //             width: 3,
                      //           )
                      //       )
                      //   ),
                      // ),
                      //
                      // SizedBox(height: 30,),

                      //Duration
                      TextFormField(
                        style: TextStyle(color: Colors.black87),
                        controller: controller.duration,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 1,
                                )
                            ),
                            label: Text("Course Duration (in weeks)", style: TextStyle(
                                fontSize: 11
                            ),),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                                Icons.timelapse_outlined,
                                color: Colors.grey
                            ),
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 3,
                                )
                            )
                        ),
                      ),

                      SizedBox(height: 30,),

                      //Price
                      TextFormField(
                        style: TextStyle(color: Colors.black87),
                        controller: controller.price,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 1,
                                )
                            ),
                            label: Text("Course Price", style: TextStyle(
                                fontSize: 11
                            ),),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                                Icons.monetization_on_outlined,
                                color: Colors.grey
                            ),
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 3,
                                )
                            )
                        ),
                      ),

                      SizedBox(height: 30,),

                      //No of Lessons
                      TextFormField(
                        style: TextStyle(color: Colors.black87),
                        controller: controller.lessonNo,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 1,
                                )
                            ),
                            label: Text("Number of Lessons", style: TextStyle(
                                fontSize: 11
                            ),),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                                Icons.numbers,
                                color: Colors.grey
                            ),
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 3,
                                )
                            )
                        ),
                      ),

                      SizedBox(height: 30,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () async {
                                if(_formkey.currentState!.validate()) {

                                  String url = await saveItem();
                                  //print("Here");

                                  CollectionReference ref = await FirebaseFirestore.instance.collection('Courses');
                                  String docId = ref.doc().id;


                                  final course = Course(
                                      id: docId,
                                      courseID: controller.courseID.text.trim(),
                                      title: controller.title.text.trim(),
                                      description: controller.description.text.trim(),
                                      createdDate: DateTime.now(),
                                      createdBy: controller.createdBy.text,
                                      thumbnailUrl: url.toString(),
                                      price: controller.price.text.trim(),
                                      duration: controller.duration.text.trim(),
                                      lessonNo: controller.lessonNo.text.trim(),
                                      //Datetime: DateTime.now()
                                  );
                                  AdminCourseController.instance.createCourse(course);
                                }

                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                decoration: BoxDecoration(
                                  color:  Colors.grey,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Text(
                                  "Upload Course",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            //   )
                            // ]


                          ),
                          SizedBox(width: 10,),
                          Container(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () async {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CourseListPage()));

                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                decoration: BoxDecoration(
                                  color:  Colors.grey,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Text(
                                  " Go To Course List",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            //   )
                            // ]


                          ),
                        ],
                      ),
                      SizedBox(height: 30,)

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
