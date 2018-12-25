import 'package:flutter/material.dart';
import 'package:our_note/ui/LoginRoute.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OurNote',
      theme: ThemeData(
        primaryColorBrightness: Brightness.light,
        primaryColor: Color(0xFFFB3353),
      ),
      home: LoginRoute(),
    );
  }
}
