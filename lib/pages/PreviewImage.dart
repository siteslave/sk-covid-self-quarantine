import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../Api.dart';

class PreviewImage extends StatefulWidget {
  @override
  _PreviewImageState createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage> {
  Api api = Api();

  final storage = new FlutterSecureStorage();

  File _image;
  final picker = ImagePicker();

  Future uploadImage(File imageFile) async {
    try {
      String token = await storage.read(key: "token");
      var response = await api.uploadImage(imageFile, token);
      var data = response.data;

      if (response.statusCode == 200) {
        print(data);
      } else {
        print('ไม่สามารถอัปโหลดได้');
      }
    } catch (error) {
      print(error);
    }
  }

  Future getImageFromCamera() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.camera);

      if (pickedFile != null) {

        print(_image);
        setState(() {
          _image = File(pickedFile.path);
        });
        // uploadImage(_image);
      } else {
        print('No image selected.');
      }
    } catch (error) {
      print(error);
    }
  }

  Future getImageFromGallery() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        // uploadImage(_image);
      } else {
        print('No image selected.');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.purple),
        title: Text(
          'อัปโหลดภาพ',
          style: TextStyle(color: Colors.purple),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.file_upload),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _image != null ? Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.center,
            height: 350,
            decoration: BoxDecoration(
                // color: Colors.white,
                image: DecorationImage(
                    image: FileImage(_image),
                ),
                // border: Border.all(color: Colors.grey, width: 2),
                // borderRadius: BorderRadius.circular(15)
            ),

          ) :
          Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.center,
            height: 250,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(15)),
            child: Icon(
              Icons.photo_camera,
              color: Colors.grey,
            ),
          ),
          FlatButton.icon(
            icon: Icon(
              Icons.camera_alt,
              color: Colors.pink,
            ),
            onPressed: () {
              getImageFromCamera();
            },
            label: Text('ภาพจากกล้อง (Camera)'),
          ),
          FlatButton.icon(
            icon: Icon(Icons.photo, color: Colors.teal),
            onPressed: () {
              getImageFromGallery();
            },
            label: Text('ภาพจากแกเลอรี่ (Gallery)'),
          ),
        ],
      ),
    );
  }
}
