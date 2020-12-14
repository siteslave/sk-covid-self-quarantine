import 'package:flutter/material.dart';

class ScreeningHistory extends StatefulWidget {
  @override
  _ScreeningHistoryState createState() => _ScreeningHistoryState();
}

class _ScreeningHistoryState extends State<ScreeningHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        title: Text('ประวัติการคัดกรอง', style: TextStyle(color: Colors.white),),
        actionsIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(child: Text('รายการประวัติการคัดกรอง'),),
    );
  }
}
