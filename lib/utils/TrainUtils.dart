import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:ujikom_efrizal/model/TrainStationData.dart';

class TrainUtils {
  Future<List<TrainStationData>> loadTrainStation() async {
    String jsonString =
        await rootBundle.loadString('assets/data/trainstation.json');
    List listdata = new List();
    List<TrainStationData> trainData = new List();

    final jsonResponse = json.decode(jsonString);
    listdata = jsonResponse;

    listdata.forEach((f) {
      trainData.add(TrainStationData(
        code: f['code'],
        name: f['location'],
      ));
    });

    return trainData;
  }
}
