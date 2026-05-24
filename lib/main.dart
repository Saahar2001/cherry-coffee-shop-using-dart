import 'package:flutter/material.dart';
import 'login_page.dart';
//slide used 160
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cherry Coffee',
      home: LoginPage(),
    );
  }
}
