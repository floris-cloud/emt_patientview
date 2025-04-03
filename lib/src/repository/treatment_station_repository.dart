import 'dart:convert';

import 'package:emt_patientview/src/repository/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/treatment_station.dart';

class TreatmentStationRepository {
  static const String _key = "treatmentStations";


   postTreatmentStation(TreatmentStation treatmentStation) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<TreatmentStation> treatmentStations = await loadTreatmentStations();
    treatmentStations.add(treatmentStation);
    String treatmentStationsJson = jsonEncode(treatmentStations);
    await prefs.setString(_key, treatmentStationsJson);

    RestApi.postTreatmentStation(treatmentStation);
  }

//  postTreatmentStation(TreatmentStation treatmentStation, int index) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final List<TreatmentStation> treatmentStations = await loadTreatmentStations();
//     treatmentStations.insert(index, treatmentStation);
//     String treatmentStationsJson = jsonEncode(treatmentStations);
//     await prefs.setString(_key, treatmentStationsJson);
//  }

  static Future<List<TreatmentStation>> getTreatmentStations() async => RestApi.getTreatmentStations();



  static  Future<List<TreatmentStation>> loadTreatmentStations() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<TreatmentStation> treatmentStations = [];
    List<TreatmentStation> treatmentStationList= await getTreatmentStations();
  
    String? treatmentStationsJson = prefs.getString(_key);
    if (treatmentStationsJson == null || treatmentStationsJson.isEmpty) {
      await prefs.setString(_key, jsonEncode(treatmentStationList));
      print(100);
      return treatmentStationList;
    }
    List<dynamic> treatStationListMap = jsonDecode(treatmentStationsJson);
    for (dynamic treatmentStationMap in treatStationListMap) {
      treatmentStations.add(TreatmentStation.fromJson(treatmentStationMap));
    }
      treatmentStations.addAll(treatmentStationList);
      return treatmentStations;
  }
  static rearrangeTreatmentStations(List<TreatmentStation> treatmentStations) async {
    
    String jsonTreatmentStations = jsonEncode(treatmentStations);
    
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
    await prefs.setString(_key, jsonTreatmentStations);

    RestApi.rearrangeTreatmentStations(treatmentStations);
  }
  static Future<void> deleteTreatmentStation(TreatmentStation treatmentStation) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<TreatmentStation> treatmentStations = await loadTreatmentStations();
    treatmentStations.removeWhere((t) => t.id == treatmentStation.id);
    String treatmentStationsJson = jsonEncode(treatmentStations);
    await prefs.setString(_key, treatmentStationsJson);
    RestApi.deleteTreatmentStation(treatmentStation);
  }
}