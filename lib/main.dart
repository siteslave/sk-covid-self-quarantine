import 'package:covid_self_quarantine/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SELF-QUARANTINE',
      home: HomePage(),
    );
  }
}



