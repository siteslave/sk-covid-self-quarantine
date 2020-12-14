import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckInWidget extends StatefulWidget {
  @override
  _CheckInWidgetState createState() => _CheckInWidgetState();
}

class _CheckInWidgetState extends State<CheckInWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      // height: 100,
      decoration: BoxDecoration(
          color: Colors.purple[50],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.purple, width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Check-In',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.purple),
              ),
              Text('Last checked-in 12.00 PM'),
              Text(
                'BIG C',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.purple, width: 1),
              ),
              child: Icon(
                Icons.add_location_alt,
                size: 55,
                color: Colors.purple,
              ))
        ],
      ),
    );
  }
}
