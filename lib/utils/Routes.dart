import 'package:flutter/material.dart';
import 'package:ujikom_efrizal/pages/MainPage.dart';
import 'package:ujikom_efrizal/pages/MainPageNew.dart';

class Routes {
  static final routes = <String, WidgetBuilder>{
    '/index': (context) => MainPage(),
    '/indexnew': (context) => MainPageNew(),
  };
}
