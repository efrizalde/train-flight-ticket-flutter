import 'package:flutter/material.dart';
import 'package:ujikom_efrizal/model/AirportData.dart';
import 'package:ujikom_efrizal/model/PaymentData.dart';
import 'package:ujikom_efrizal/model/RoutesData.dart';
import 'package:ujikom_efrizal/pages/Checkout.dart';
import 'package:ujikom_efrizal/pages/PaymentConfirmation.dart';
import 'package:ujikom_efrizal/pages/Profile.dart';
import 'package:ujikom_efrizal/pages/UserOrders.dart';
import 'package:ujikom_efrizal/pages/components/AirportSearch.dart';

class MyNavig {
  Future<dynamic> goToCheckout(BuildContext context, RoutesData rdata,
      String outlet, DateTime dt) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FlightCheckout(
              dt: dt,
              outlet: outlet,
              rdata: rdata,
            ),
      ),
    );
  }

  Future<dynamic> goToFlightSearch(
      BuildContext context, AirportData data, List<AirportData> datas) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AirportSearch(
              airportData: datas,
            ),
      ),
    );
  }

  Future<dynamic> goToPayConfirm(
      BuildContext context, PaymentData payData) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PayConfirm(
              data: payData,
            ),
      ),
    );
  }

  Future<dynamic> goToMyOrder(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UserOrders(),
      ),
    );
  }

  Future<dynamic> goToMyProfile(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }
}
