import 'package:flutter/material.dart';
import 'package:ujikom_efrizal/pages/Login.dart';
import 'package:ujikom_efrizal/pages/MainPage.dart';
import 'package:ujikom_efrizal/pages/MainPageNew.dart';
import 'package:ujikom_efrizal/pages/Register.dart';

class Routes {
  static final routes = <String, WidgetBuilder>{
    '/login': (context) => LoginPage(),
    '/register': (context) => RegisterPage(),
    '/index': (context) => MainPage(),
    '/indexnew': (context) => MainPageNew(),
  };
}
