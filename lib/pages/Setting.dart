import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  final int userId;
  final String fullName;

  Setting({@required this.userId, this.fullName});

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple,
        title: Text('Setting', style: TextStyle(color: Colors.white),),
        actionsIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(child: Text('สมาชิก: ${widget.fullName ?? 'Satit Rianpit'} (รหัสสมาชิก: ${widget.userId})'),),
    );
  }
}
