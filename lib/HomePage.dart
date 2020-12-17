import 'dart:convert';
import 'dart:ui';

import 'package:covid_self_quarantine/pages/Login.dart';
import 'package:covid_self_quarantine/pages/Setting.dart';
import 'package:covid_self_quarantine/widgets/CallEmergencyWidget.dart';
import 'package:covid_self_quarantine/widgets/CheckInWidget.dart';
import 'package:covid_self_quarantine/widgets/ImageProfileWidget.dart';
import 'package:covid_self_quarantine/widgets/MainMenuWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'widgets/charts/Bar.dart';
import 'widgets/charts/Donut.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.admin_panel_settings_rounded,
                color: Colors.purple,
                size: 40,
              ),
            ),
            Text(
              'SELF-QUARANTINE',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              size: 25,
              color: Colors.purple,
            ),
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Setting(
                        userId: 20,
                      )));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              size: 25,
              color: Colors.purple,
            ),
            onPressed: () async {
              final storage = new FlutterSecureStorage();
              await storage.delete(key: "token");
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Login()));
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ImageProfileWidget(),
          CheckInWidget(),
          CallEmergencyWidget(),
          Container(
              color: Colors.white,
              height: 200,
              width: 200,
              child: Column(
                children: [
                  Text('สรุปผู้ป่วย',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(child: DonutChart()),
                ],
              )),
          Container(
              color: Colors.white,
              height: 200,
              width: 200,
              child: Column(
                children: [
                  Text('สรุปผู้ป่วย',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(child: BarChart()),
                ],
              )),
          MainMenuWidget()
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('บันทึกคัดกรอง'),
        icon: Icon(Icons.fact_check),
        backgroundColor: Colors.pink,
        onPressed: () async {
          Map user = {
            "id": 1,
            "first_name": "Satit",
            "last_name": "Rianpit",
            "roles": ["Admin", "Manager"]
          };
          await storage.write(key: 'user', value: json.encode(user));
          String strUser = await storage.read(key: 'user');
          print(strUser);
          Map _user = json.decode(strUser);
          print(_user['first_name']);
          print(_user['last_name']);
          print(_user['roles']);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
