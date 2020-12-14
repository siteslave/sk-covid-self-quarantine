import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageProfileWidget extends StatefulWidget {
  @override
  _ImageProfileWidgetState createState() => _ImageProfileWidgetState();
}

class _ImageProfileWidgetState extends State<ImageProfileWidget> {
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
                          'https://randomuser.me/api/portraits/men/36.jpg'))),
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
          'Mr. Satit Rianpit',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
