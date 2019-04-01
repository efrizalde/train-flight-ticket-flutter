import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    if (mounted) {
      Timer(Duration(seconds: 2),
          () => Navigator.pushReplacementNamed(context, '/login'));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _spashScreenBody() {
      return Container(
        alignment: Alignment.center,
        child: Icon(Icons.airplanemode_active),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: _spashScreenBody(),
    );
  }
}
