import 'package:covid_self_quarantine/pages/About.dart';
import 'package:covid_self_quarantine/pages/CheckedInHistory.dart';
import 'package:covid_self_quarantine/pages/ScreeningHistory.dart';
import 'package:flutter/material.dart';

class MainMenuWidget extends StatefulWidget {
  @override
  _MainMenuWidgetState createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget> {
  bool isGetNotify = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 20),
          child: Text(
            'เมนูหลัก',
            style: TextStyle(
                fontSize: 20,
                color: Colors.black45,
                fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              ListTile(
                title: Text('View checked-in'),
                leading: CircleAvatar(
                  child: Icon(
                    Icons.add_location_alt,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.purple,
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CheckedInHistory(), fullscreenDialog: false));
                },
              ),
              ListTile(
                title: Text('View Screening'),
                leading: CircleAvatar(
                  child: Icon(
                    Icons.fact_check,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.orange,
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ScreeningHistory(), fullscreenDialog: false));
                },
              ),
              ListTile(
                title: Text('About this app'),
                leading: CircleAvatar(
                  child: Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.teal,
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => About(), fullscreenDialog: true));
                },
              ),
              CheckboxListTile(
                title: const Text('รับข้อมูลข่าวสารจากแอป'),
                activeColor: Colors.pink,
                value: isGetNotify,
                onChanged: (bool value) {
                  setState(() {
                    isGetNotify = value;
                  });
                },
                secondary: CircleAvatar(
                  child: Icon(
                    Icons.notifications_active_rounded,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.pink,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
