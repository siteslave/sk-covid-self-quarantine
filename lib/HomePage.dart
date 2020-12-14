import 'dart:ui';

import 'package:covid_self_quarantine/pages/Setting.dart';
import 'package:covid_self_quarantine/widgets/CallEmergencyWidget.dart';
import 'package:covid_self_quarantine/widgets/CheckInWidget.dart';
import 'package:covid_self_quarantine/widgets/ImageProfileWidget.dart';
import 'package:covid_self_quarantine/widgets/MainMenuWidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                size: 45,
              ),
            ),
            Text(
              'SELF-QUARANTINE',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
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
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Setting(
                        userId: 20,
                      )));
            },
          )
        ],
      ),
      body: ListView(
        children: [
          ImageProfileWidget(),
          CheckInWidget(),
          CallEmergencyWidget(),
          MainMenuWidget()
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('บันทึกคัดกรอง'),
        icon: Icon(Icons.fact_check),
        backgroundColor: Colors.pink,
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
