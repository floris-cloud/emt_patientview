import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/patient.dart';
import '../models/treatment_station.dart';

class RestApi {
  static String uri = 'localhost:8020';

  static Future<List<Patient>> getPatientList() async {
    var url = 'http://$uri/patients';
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      List<Patient> patients = [];
      List<dynamic> json = jsonDecode(response.body);
      print(json);
      json.forEach((jsonP) {patients.add(Patient.fhirJson(jsonP));});
      return patients;
    }else{
      throw Exception('Failed to load patients');
    }
}

static postTreatmentStation(TreatmentStation ts) async {
  var url = 'http://$uri/treatmentStation';
  var response = await http.post(Uri.parse(url), body: jsonEncode(ts.toJson()));
  if(response.statusCode != 200) {
    throw Exception('Failed to load patients');
  }
}
static Future<List<TreatmentStation>> getTreatmentStations() async {
  var url = 'http://$uri/treatmentStation';
  var response = await http.get(Uri.parse(url));
  if(response.statusCode != 200) {
    throw Exception('Failed to load TreatmentStations');
  }
  List<TreatmentStation> treatmentStations = [];
  List<dynamic> json = jsonDecode(response.body);
  json.forEach((jsonP) {treatmentStations.add(TreatmentStation.fromJson(jsonP));});
  return treatmentStations;
}
}