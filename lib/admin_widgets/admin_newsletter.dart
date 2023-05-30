import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gymha/admin_widgets/admin_controllers/admin_newsletter_controller.dart';
import 'package:get/get.dart';
import 'package:gymha/admin_widgets/admin_models/admin_newsletter_model.dart';
import 'package:gymha/widgets/responsive.dart';


class AdminNewsletter extends StatefulWidget {
  const AdminNewsletter({Key? key}) : super(key: key);

  @override
  State<AdminNewsletter> createState() => _AdminNewsletterState();
}

class _AdminNewsletterState extends State<AdminNewsletter> {

  String selctFile = '';
 // late XFile file;
  late Uint8List selectedImageInBytes;
 // List<Uint8List> pickedImagesInBytes = [];
  String imageUrl = '';
  int imageCounts = 0;
 // TextEditingController _itemNameController = TextEditingController();
  bool isItemSaved = false;


  @override
  void initState() {
    super.initState();
    }

    //To select images for Desktop
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
          .child('Newsletter Collection')
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



    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(75.0),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 5,
              leading: Padding(
                padding: const EdgeInsets.all(15.0),
                child: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back, color: Color(0xFF7c2dcb),)),
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 13.0),
                child: Text("Upload New Newsletter", style: TextStyle(
                  color: Color(0xFF7c2dcb),
                  fontSize: isMobile? 16: 20,
                  fontWeight: FontWeight.w500,
                ),),
              ),
            ),
          ),
          body: SingleChildScrollView(
              child: isMobile? BodyMobile(w,h): BodyDesktop(w,h)

          ),



        )
    );
  }

  Widget BodyMobile(double w, double h){
    final controller = Get.put(AdminNewsletterController());
    final _formkey = GlobalKey<FormState>();


    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF7c2dcb),
            Color(0xFFbeabfc),
            Color(0xFFd6c6fc)

          ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight
          ),
        ),
        padding: EdgeInsets.all(30),
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
                      child: Text("Upload title, subtitle and image in the blog post.Just click on the PUBLISH button to publish the newsletter",
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
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFc700c9))),
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


                    //TITLE
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("TITLE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            Text("Max 300 characters", style: TextStyle(color: Colors.white70, fontSize: 10),),
                          ],
                        )
                    ),
                    TextFormField(
                      //initialValue: user.name,
                      controller: controller.title,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black38,
                                width: 2,
                              )
                          ),
                          label: Text("Title", style: TextStyle(
                              fontSize: 11
                          ),),
                          border: OutlineInputBorder(),
                          // prefixIcon: Icon(
                          //     LineAwesomeIcons.user,
                          //     color: Colors.white
                          // ),
                          labelStyle: TextStyle(color: Colors.black38),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2 ,
                              )
                          )
                      ),
                    ),

                    SizedBox(height: 20,),

                    //WRITER
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("WRITER", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            Text("Max 300 characters", style: TextStyle(color: Colors.white70, fontSize: 10),),
                          ],
                        )
                    ),
                    TextFormField(
                      //initialValue: user.name,
                      controller: controller.writer,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black38,
                                width: 2,
                              )
                          ),
                          label: Text("Title", style: TextStyle(
                              fontSize: 11
                          ),),
                          border: OutlineInputBorder(),
                          // prefixIcon: Icon(
                          //     LineAwesomeIcons.user,
                          //     color: Colors.white
                          // ),
                          labelStyle: TextStyle(color: Colors.black38),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2 ,
                              )
                          )
                      ),
                    ),

                    SizedBox(height: 20,),

                    //SUBTITLE
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("SUBTITLE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            Text("Max 500 characters", style: TextStyle(color: Colors.white70, fontSize: 10),),
                          ],
                        )
                    ),
                    TextFormField(
                      //initialValue: user.name,
                      controller: controller.subtitle,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black38,
                                width: 2,
                              )
                          ),
                          label: Text("Subtitle", style: TextStyle(
                              fontSize: 11
                          ),),
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.black38),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2 ,
                              )
                          )
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    //CONTENT
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("NEWSLETTER CONTENT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            //Text("Max 500 characters", style: TextStyle(color: Colors.white70, fontSize: 10),),
                          ],
                        )
                    ),
                    Container(
                      // height: h/.25,
                      // width: w/1.5,
                      // padding: EdgeInsets.symmetric(horizontal: 20),
                      child:
                      TextField(
                        controller: controller.content,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                  width: 2,
                                )
                            ),
                            label: Text("Newsletter Content", style: TextStyle(
                                fontSize: 11
                            ),),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2 ,
                                )
                            )
                        ),
                      ),
                    ),




                    SizedBox(
                      height: 20,
                    ),


                    Container(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () async {
                          if(_formkey.currentState!.validate()) {

                            String url = await saveItem();


                            final Newsletter = NewsletterModel(
                                title: controller.title.text.trim(),
                                writer: controller.writer.text.trim(),
                                subtitle: controller.subtitle.text.trim(),
                                content: controller.content.text,
                                imageName: url.toString(),
                                Datetime: DateTime.now()
                            );
                            AdminNewsletterController.instance.createNewsletter(Newsletter);
                          }

                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFc700c9),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            "Upload Newsletter",
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
              ),
            ),
            // VerticalDivider( thickness: 10, color: Colors.white,),
            // Text("Test", style: TextStyle(fontSize: 40),)
          ],
        )
    );
  }

  Widget BodyDesktop(double w, double h){

    final controller = Get.put(AdminNewsletterController());
    final _formkey = GlobalKey<FormState>();


    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF7c2dcb),
            Color(0xFFbeabfc),
            Color(0xFFd6c6fc)

          ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight
          ),
        ),
        padding: EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: w/2,
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text("Upload title, subtitle and image in the blog post.Just click on the PUBLISH button to publish the newsletter",
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

                    //IMAGE
                    Container(
                        height: h * 0.45,
                        width: w * 0.65,
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
                            //_showPicker(context);
                            _selectFile(true);
                          },
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFc700c9))),
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


                    //TITLE
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("TITLE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            Text("Max 300 characters", style: TextStyle(color: Colors.white70, fontSize: 10),),
                          ],
                        )
                    ),
                    TextFormField(
                      //initialValue: user.name,
                      controller: controller.title,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black38,
                                width: 2,
                              )
                          ),
                          label: Text("Title", style: TextStyle(
                              fontSize: 11
                          ),),
                          border: OutlineInputBorder(),
                          // prefixIcon: Icon(
                          //     LineAwesomeIcons.user,
                          //     color: Colors.white
                          // ),
                          labelStyle: TextStyle(color: Colors.black38),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2 ,
                              )
                          )
                      ),
                    ),

                    SizedBox(height: 20,),

                    //WRITER
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("WRITER", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            Text("Max 300 characters", style: TextStyle(color: Colors.white70, fontSize: 10),),
                          ],
                        )
                    ),
                    TextFormField(
                      controller: controller.writer,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black38,
                                width: 2,
                              )
                          ),
                          label: Text("Writer", style: TextStyle(
                              fontSize: 11
                          ),),
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.black38),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2 ,
                              )
                          )
                      ),
                    ),

                    SizedBox(height: 20,),

                    //SUBTITLE
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("SUBTITLE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            Text("Max 500 characters", style: TextStyle(color: Colors.white70, fontSize: 10),),
                          ],
                        )
                    ),
                    TextFormField(
                      //initialValue: user.name,
                      controller: controller.subtitle,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black38,
                                width: 2,
                              )
                          ),
                          label: Text("Subtitle", style: TextStyle(
                              fontSize: 11
                          ),),
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.black38),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2 ,
                              )
                          )
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    //CONTENT
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("NEWSLETTER CONTENT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            //Text("Max 500 characters", style: TextStyle(color: Colors.white70, fontSize: 10),),
                          ],
                        )
                    ),
                    Container(
                      // height: h/.25,
                      // width: w/1.5,
                      // padding: EdgeInsets.symmetric(horizontal: 20),
                      child:
                      TextField(
                        controller: controller.content,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                  width: 2,
                                )
                            ),
                            label: Text("Newsletter Content", style: TextStyle(
                                fontSize: 11
                            ),),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2 ,
                                )
                            )
                        ),
                      ),
                    ),




                    SizedBox(
                      height: 20,
                    ),


                    Container(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () async {
                          if(_formkey.currentState!.validate()) {

                            String url = await saveItem();


                            // phone and email authentication

                            final Newsletter = NewsletterModel(
                              title: controller.title.text.trim(),
                              writer: controller.writer.text.trim(),
                              subtitle: controller.subtitle.text.trim(),
                              content: controller.content.text,
                              imageName: url.toString(),
                              Datetime: DateTime.now()
                            );
                            AdminNewsletterController.instance.createNewsletter(Newsletter);


                          }

                          },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFc700c9),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            "Upload Newsletter",
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
              ),
            ),
            // VerticalDivider( thickness: 10, color: Colors.white,),
            // Text("Test", style: TextStyle(fontSize: 40),)
          ],
        )
    );
  }
}
