import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:ujikom_efrizal/model/AirportData.dart';

class AirportUtils {
  Future<List<AirportData>> loadAirport() async {
    String jsonString =
        await rootBundle.loadString('assets/data/airports.json');
    List listdata = new List();
    List<AirportData> airportData = new List();

    final jsonResponse = json.decode(jsonString);
    listdata = jsonResponse;

    listdata.forEach((f) {
      if (f['country'] == "Indonesia") {
        airportData.add(AirportData(
          code: f['code'],
          lat: f['lat'],
          lon: f['lon'],
          name: f['name'],
          city: f['city'],
          state: f['state'],
          country: f['country'],
          woeid: f['woeid'],
          tz: f['tz'],
          phone: f['phone'],
          type: f['type'],
          email: f['email'],
          url: f['url'],
          runwaylength: f['runway_length'],
          elev: f['elev'],
          icao: f['icao'],
          directflights: f['direct_flights'],
          carriers: f['carriers'],
        ));
      }
    });

    return airportData;
  }
}
