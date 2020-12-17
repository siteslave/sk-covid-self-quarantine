import 'dart:io';

import 'package:covid_self_quarantine/Api.dart';
import 'package:covid_self_quarantine/pages/PreviewImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageProfileWidget extends StatefulWidget {
  @override
  _ImageProfileWidgetState createState() => _ImageProfileWidgetState();
}

class _ImageProfileWidgetState extends State<ImageProfileWidget> {
  Api api = Api();

  final storage = new FlutterSecureStorage();

  String imageUrl;
  String fullname;

  String userToken;

  Future getInfo() async {
    try {
      String token = await storage.read(key: "token");
      setState(() {
        userToken = token;
      });
      var response = await api.getInfo(token);
      var data = response.data;

      if (data['first_name'] != null) {
        setState(() {
          imageUrl = data['image_url'];
          fullname = '${data['first_name']} ${data['last_name']}';
        });
      } else {
        print('ไม่พบข้อมูลผู้ใช้งาน');
      }
    } catch (error) {
      print(error);
    }
  }

  // void showModal() {
  //   showModalBottomSheet<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         height: 200,
  //         color: Colors.white,
  //         child: Center(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               const Text(
  //                 'เลือกแหล่งภาพ',
  //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //               ),
  //               ListTile(
  //                 title: Text('จากกล้อง (Camera)'),
  //                 leading: Icon(Icons.camera_alt),
  //                 onTap: () {
  //                   // Navigator.of(context).pop();
  //                   getImageFromCamera();
  //                 },
  //               ),
  //               ListTile(
  //                 title: Text('จากแกลอลี่ (Gallery)'),
  //                 leading: Icon(Icons.photo_album),
  //                 onTap: () {
  //                   // Navigator.of(context).pop();
  //                   getImageFromGallery();
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  color: Colors.red,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          '${api.apiUrl}/api/quarantine/image-profile',
                          headers: {'Authorization': 'Bearer $userToken'}))),
            ),
            Positioned(
              bottom: 20,
              right: 5,
              child: Container(
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    size: 35,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PreviewImage(),
                        fullscreenDialog: true));
                  },
                ),
              ),
            )
          ],
        ),
        Text(
          '${fullname ?? "DEMO DEMO"}',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
