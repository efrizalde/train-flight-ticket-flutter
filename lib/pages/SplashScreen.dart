import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ujikom_efrizal/utils/services/PenumpangServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences prefs;
  @override
  void initState() {
    if (mounted) {
      PenumpangServices().getUname().then((uname) {
        PenumpangServices().check(uname).then((islogin) {
          if (islogin) {
            Timer(Duration(seconds: 1),
                () => Navigator.pushReplacementNamed(context, '/indexnew'));
          } else {
            Timer(Duration(seconds: 1),
                () => Navigator.pushReplacementNamed(context, '/login'));
          }
        }).catchError((e) {
          print(e.toString());
          Timer(Duration(seconds: 1),
              () => Navigator.pushReplacementNamed(context, '/login'));
        });
      });
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
