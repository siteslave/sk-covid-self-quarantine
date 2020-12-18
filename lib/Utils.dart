
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Utils {

  Utils();

  String toThaiDate(DateTime date) {
    // create format
    var strDate = new DateFormat.MMMd('th_TH').format(date);
    var _strDate = '$strDate ${date.year + 543}';
    // return thai date
    return _strDate;
  }

  String toLongThaiDate(DateTime date) {
    // create format
    var strDate = new DateFormat.MMMMd('th_TH').format(date);
    var _strDate = '$strDate ${date.year + 543}';
    // return thai date
    return _strDate;
  }

  void errorAlert() {
    Fluttertoast.showToast(
        msg: "เกิดข้อผิดพลาด",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  void successAlert() {
    Fluttertoast.showToast(
        msg: "ดำเนินการเสร็จเรียบร้อย",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}