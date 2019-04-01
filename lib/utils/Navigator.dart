import 'package:flutter/material.dart';
import 'package:ujikom_efrizal/model/AirportData.dart';
import 'package:ujikom_efrizal/model/PaymentData.dart';
import 'package:ujikom_efrizal/pages/FlightCheckout.dart';
import 'package:ujikom_efrizal/pages/FlightSearchResult.dart';
import 'package:ujikom_efrizal/pages/PaymentConfirmation.dart';
import 'package:ujikom_efrizal/pages/components/AirportSearch.dart';

class MyNavig {
  Future<dynamic> goToCheckout(BuildContext context, AirportData ddata,
      AirportData adata, DateTime fDate, int person) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FlightCheckout(
              dData: ddata,
              aData: adata,
              flightDate: fDate,
              person: person,
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

  Future<dynamic> goToFlightResult(BuildContext context, AirportData ddata,
      AirportData adata, DateTime fDate, int person) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FlightResult(
              dData: ddata,
              aData: adata,
              flightDate: fDate,
              person: person,
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
}
