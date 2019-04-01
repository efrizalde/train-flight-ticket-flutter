import 'package:flutter/material.dart';
import 'package:ujikom_efrizal/pages/SplashScreen.dart';
import 'package:ujikom_efrizal/utils/Routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travelijal',
      routes: Routes.routes,
      theme: ThemeData(
        primaryColor: Color(0xff1fab89),
        accentColor: Color(0xff62d2a2),
      ),
      home: SplashScreen(),
    );
  }
}
