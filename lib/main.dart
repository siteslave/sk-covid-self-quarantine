import 'package:covid_self_quarantine/HomePage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import './pages/Login.dart';
import 'package:flutter/material.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final storage = new FlutterSecureStorage();
  bool isLogged = false;
  String token = await storage.read(key: 'token');

  if (token != null) {
    // check expired?
    bool hasExpired = JwtDecoder.isExpired(token);
    if (!hasExpired) {
      isLogged = true;
    }
  }

  runApp(Main(isLogged));
}

class Main extends StatelessWidget {
  final bool isLogged;

  Main(this.isLogged);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SELF-QUARANTINE',
      home: this.isLogged ? HomePage() : Login(),
    );
  }
}
