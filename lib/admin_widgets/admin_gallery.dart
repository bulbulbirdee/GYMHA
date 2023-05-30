import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymha/widgets/responsive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;

class AdminGallery extends StatefulWidget {
  @override
  State<AdminGallery> createState() => _AdminGalleryState();
}

class _AdminGalleryState extends State<AdminGallery> {

  String selctFile = '';
  late XFile file;
  late Uint8List selectedImageInBytes;
  List<Uint8List> pickedImagesInBytes = [];
  List<String> imageUrls = [];
  int imageCounts = 0;
  final _itemNameController = TextEditingController();
  final _itemDescriptionController = TextEditingController();
  bool isItemSaved = false;


  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();

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

  Future<String> _uploadFile() async {
    String imageUrl = '';
    try {
      firabase_storage.UploadTask uploadTask;

      firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
          .ref()
          .child('Gallery')
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

  Future<String> _uploadMultipleFiles(String itemName) async {
    String imageUrl = '';
    try {
      for (var i = 0; i < imageCounts; i++) {
        firabase_storage.UploadTask uploadTask;

        firabase_storage.Reference ref = firabase_storage
            .FirebaseStorage.instance
            .ref()
            .child('Gallery')
            .child('/' + itemName + '_' + i.toString());

        final metadata =
        firabase_storage.SettableMetadata(contentType: 'image/jpeg');

        //uploadTask = ref.putFile(File(file.path));
        uploadTask = ref.putData(pickedImagesInBytes[i], metadata);

        await uploadTask.whenComplete(() => null);
        imageUrl = await ref.getDownloadURL();
        setState(() {
          imageUrls.add(imageUrl);
        });
      }
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

      await FirebaseFirestore.instance.collection('Gallery').doc().set({
         'imageName': _itemNameController.text,
         'imageDescription': _itemDescriptionController.text,
         'imageURL' : imageUrl.toString()
       })
        .then((value) {
        //sendPushMessage();
        setState(() {
          isItemSaved = false;
        });
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
      });
    }
  }

  String constructFCMPayload(String token) {
    return jsonEncode({
      'to': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
      },
      'notification': {
        'title': 'Your item  ${_itemNameController.text} is added successfully !',
        'body': 'Done',
      },
    });
  }

  // Future<void> sendPushMessage() async {
  //   if (_deviceTokenController.text == null) {
  //     print('Unable to send FCM message, no token exists.');
  //     return;
  //   }
  //
  //   try {
  //     String serverKey = "AAAA0RJf2UE:APA91bE_M-axKmqqoV5EinizvWP4T9bOkmCXAwU8JPFCEQsVCZXBdgsX2Nq_coDtvo49ULywfLtzorKS0TlB-1LxNQhFZRBrbk6hcoD0fgHy-i3ed0ehx7yDaHxYLzjXAt7vO2XDMIBD";
  //     await http.post(
  //       Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'key=$serverKey'
  //       },
  //       body: constructFCMPayload(_deviceTokenController.text),
  //     );
  //     print('FCM request for device sent!');
  //   } catch (e) {
  //     print(e);
  //   }
  // }




// The UI


  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  Widget build(BuildContext context) {

    const Color gradientEndColor = Color(0xff11998e);
    const Color gradientStartColor = Color(0xFFc700c9);

    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    bool isMobile = ResponsiveWidget.isSmallScreen(context)? true : false;


    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 5,
          leading: Padding(
            padding: const EdgeInsets.all(15.0),
            child: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back, color: Color(0xFFc700c9),)),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 13.0),
            child: Text("Upload Images to Gallery", style: TextStyle(
              color: Color(0xFFc700c9),
              fontSize: isMobile? 16: 20,
              fontWeight: FontWeight.w500,
            ),),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                gradientStartColor,
                gradientEndColor
              ],
              begin: const FractionalOffset(0.2, 0.2),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: SingleChildScrollView(
          child: Container(
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //       colors: [
            //         gradientStartColor,
            //         gradientEndColor
            //       ],
            //       begin: const FractionalOffset(0.2, 0.2),
            //       end: const FractionalOffset(1.0, 1.0),
            //       stops: [0.0, 1.0],
            //       tileMode: TileMode.clamp),
            // ),
            // child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width * 0.65,
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
                            :
                        // CarouselSlider(
                        //   options: CarouselOptions(height: 400.0),
                        //   items: pickedImagesInBytes.map((i) {
                        //     return Builder(
                        //       builder: (BuildContext context) {
                               Stack(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                                        decoration:
                                        BoxDecoration(color: Colors.white),
                                        child: Image.memory(selectedImageInBytes),
                                      ),
                                      // Align(
                                      //   child: CloseButton(
                                      //     color: Colors.red,
                                      //     onPressed: () {
                                      //       pickedImagesInBytes.remove(i);
                                      //       Image.memory(i);
                                      //       },
                                      //   ),
                                      //   alignment: Alignment.topRight,
                                      // ),
                                    ]
                                ),
                            //  },
                           // );
                         // }).toList(),
                       // )
                      //Image.memory(selectedImageInBytes)

                      // Image.file(
                      //     File(file.path),
                      //     fit: BoxFit.fill,
                      //   ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          isMobile?_showPicker(context)
                          : _selectFile(true);
                        },
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFc700c9))),
                        icon: const Icon(
                          Icons.camera,
                        ),
                        label: const Text(
                          'Pick Image',
                          style: TextStyle(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    if (isItemSaved)
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                      ),
                      child: TextField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          border: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            borderSide: new BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          labelText: 'Image Label',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        controller: _itemNameController,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                      ),
                      child: TextField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          border: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            borderSide: new BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          labelText: 'Image Description',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        controller: _itemDescriptionController,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),

                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFFc700c9))),
                      onPressed: () {
                        saveItem();
                        //print(_itemNameController.text);
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
        ),
      ),
    );
  }
}