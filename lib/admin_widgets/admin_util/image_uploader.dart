import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ImageUploader extends StatefulWidget {
  const ImageUploader({Key? key}) : super(key: key);

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {

  String selctFile = '';
  // late XFile file;
  late Uint8List selectedImageInBytes;
  // List<Uint8List> pickedImagesInBytes = [];
  String imageUrl = '';
  int imageCounts = 0;
  // TextEditingController _itemNameController = TextEditingController();
  bool isItemSaved = false;

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
    return const Placeholder();
  }
}
