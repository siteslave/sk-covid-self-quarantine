import 'package:flutter/material.dart';

class CallEmergencyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'โทรปรึกษากรมควบคุมโรค',
            style: TextStyle(
                fontSize: 20,
                color: Colors.black45,
                fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          // height: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.amber)),
          child: Row(
            children: [
              CircleAvatar(
                child: Icon(
                  Icons.call,
                  color: Colors.amber[800],
                ),
                backgroundColor: Colors.amber[50],
                radius: 30,
              ),
              SizedBox(width: 18,),
              Expanded(
                  child: Text(
                'โทร 1422 เพื่อขอคำปรึกษา หรือนัดเข้าตรวจหาเชื้อโควิด-19',
                style: TextStyle(fontSize: 16),
              ))
            ],
          ),
        ),
      ],
    );
  }
}
