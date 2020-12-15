import 'package:covid_self_quarantine/Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ImageProfileWidget extends StatefulWidget {
  @override
  _ImageProfileWidgetState createState() => _ImageProfileWidgetState();
}

class _ImageProfileWidgetState extends State<ImageProfileWidget> {

  Api api = Api();

  final storage = new FlutterSecureStorage();

  String imageUrl;
  String fullname;

  Future getInfo() async {
    try {
      String token = await storage.read(key: "token");
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
                          '${imageUrl ?? 'https://via.placeholder.com/150'}'))),
            ),
            Positioned(
              bottom: 20,
              right: 5,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                      shape: BoxShape.circle
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    size: 35,
                    color: Colors.black54,
                  ),
                  onPressed: () {},
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
