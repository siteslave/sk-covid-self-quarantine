import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Image(
              image: AssetImage('images/logo.png'),
              height: 80,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('เข้าสู่ระบบ'),
                TextFormField(),
                TextFormField(),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: RaisedButton.icon(
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        color: Colors.purple,
                        textColor: Colors.white,
                        icon: Icon(Icons.keyboard),
                        onPressed: () {},
                        label: Text(
                          'เข้าสู่ระบบ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  RaisedButton(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.pink,
                    textColor: Colors.white,
                    onPressed: () {},
                    child: Text(
                      'GOOGLE',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  RaisedButton(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    onPressed: () {},
                    child: Text(
                      'FACEBOOK',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],)

              ],
            ),
          )
        ],
      ),
    );
  }
}
