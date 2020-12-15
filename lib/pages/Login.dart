import 'package:covid_self_quarantine/Api.dart';
import 'package:covid_self_quarantine/HomePage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  Api api = Api();

  TextEditingController ctrlUsername = TextEditingController();
  TextEditingController ctrlPassword = TextEditingController();

  final storage = new FlutterSecureStorage();

  Future doLogin() async {
    String username = ctrlUsername.text;
    String password = ctrlPassword.text;

    try {
      Response response = await api.login(username, password);
      var data = response.data;
      if (data['token'] != null) {
        String token = data['token'];
        await storage.write(key: 'token', value: token);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        print(data['message']);
      }
    } catch (error) {
      print(error);
    }
  }

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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.admin_panel_settings,
                            color: Colors.purple, size: 45),
                        Text(
                          'SELF-QUARANTINE',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: ctrlUsername,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'กรุณระบุชื่อผู้ใช้งาน';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'ชื่อผู้ใช้งาน',
                        labelStyle: TextStyle(color: Colors.purple),
                        prefixIcon: Icon(Icons.person, color: Colors.purple),
                        border: InputBorder.none,
                        fillColor: Colors.grey[100],
                        filled: true),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: ctrlPassword,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'กรุณระบุรหัสผ่าน';
                      }

                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'รหัสผ่าน',
                        labelStyle: TextStyle(color: Colors.purple),
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.purple,
                        ),
                        border: InputBorder.none,
                        fillColor: Colors.grey[100],
                        filled: true),
                  ),
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
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              doLogin();
                            }
                          },
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
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
