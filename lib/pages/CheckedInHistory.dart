import 'package:flutter/material.dart';

class CheckedInHistory extends StatefulWidget {
  @override
  _CheckedInHistoryState createState() => _CheckedInHistoryState();
}

class _CheckedInHistoryState extends State<CheckedInHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple,
        title: Text('ประวัติการเช็คอิน', style: TextStyle(color: Colors.white),),
        actionsIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(child: Text('รายการประวัติการเช็คอิน'),),
    );
  }
}
