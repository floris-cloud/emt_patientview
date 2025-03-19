import 'dart:convert';
import 'dart:io';
import 'package:file_saver/file_saver.dart';
import 'package:http/http.dart' as http;
import '../models/patient.dart';
import '../models/protocol.dart';
import '../models/treatment_station.dart';

class RestApi {
  static String uri = 'localhost:8020';
  // static String uri = 'floris-20df0051ge.local:8020';


  static Future<List<Patient>> getPatientList() async {
    var url = 'http://$uri/patients';
    try {
    var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
      List<Patient> patients = [];
      List<dynamic> json = jsonDecode(response.body);
      json.forEach((jsonP) {patients.add(Patient.fromMap(jsonP));});
      return patients;
      
      }
      else{
        return [];
      }
    }
    catch(e) {
      return [];
    }
}
static postPatient(Patient patient) async {
  var url = 'http://$uri/patient';
  print(jsonEncode(patient.getFhirPatient()));
  var response = await http.post(Uri.parse(url), body: jsonEncode(patient));
  if(response.statusCode != 200) {
    throw Exception('Failed to post Patient');
  }
}
static changePatient(Patient patient) async {
  var url = 'http://$uri/patient';
  var response = await http.put(Uri.parse(url), body: jsonEncode(patient));
  if(response.statusCode != 200) {
    throw Exception('Failed to change Patient');
  }
}
static postTreatmentStation(TreatmentStation ts) async {
  var url = 'http://$uri/treatmentStation';
  print(jsonEncode(ts));

  var response = await http.post(Uri.parse(url), body: jsonEncode(ts.toJson()));
  if(response.statusCode != 200) {
    throw Exception('Failed to post TreatmentStation');
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
  if(json.isEmpty) {
    return treatmentStations;
  }
  print(json);
  json.forEach((jsonP) {treatmentStations.add(TreatmentStation.fromJson(jsonDecode(jsonP)));});
  return treatmentStations;
}

  static void postTreatmentStations(List<TreatmentStation> treatmentStations) async {
    var url = 'http://$uri/treatmentStations';
    try {
      var response = await http.post(Uri.parse(url), body: jsonEncode(treatmentStations));
      if(response.statusCode != 200) {
        print('Failed to post TreatmentStations');
      }
    }
    catch(e) {
      print(e);
    }
  }
  static void rearrangeTreatmentStations(List<TreatmentStation> treatmentStations) async {
      var url = 'http://$uri/treatmentStations';
    try {
      var response = await http.put(Uri.parse(url), body: jsonEncode(treatmentStations));
      if(response.statusCode != 200) {
        print('Failed to rearrange TreatmentStations');
      }
    }
    catch(e) {
      print(e);
    }
  }
  
  static void deleteTreatmentStation(TreatmentStation treatmentStation) {
    if(treatmentStation.dbId == null) {
      return;
    }
    var url = 'http://$uri/treatmentStation/';
    http.delete(Uri.parse(url), body: jsonEncode(treatmentStation));
  }
  static Future<List<Protocol>> getProtocols(Patient patient) async {
    var url = 'http://$uri/protocol/';
    var request = http.Request('GET', Uri.parse(url));
    request.body = patient.id;
    var response = await request.send();
    if(response.statusCode != 200) {
      throw Exception('Failed to get Protocol');
    }
    List<Protocol> protocols = [];
    List<dynamic> json = jsonDecode(response.stream.toString());
    json.forEach((jsonP) {protocols.add(Protocol.fromMap(jsonP));});
    return protocols;
  }
  
  static void postProtocol(Protocol protocol) async {
    var url = 'http://$uri/protocol';
    var response = await http.post(Uri.parse(url), body: jsonEncode(protocol.toJson()));
    if(response.statusCode != 200) {
      throw Exception('Failed to post Protocol');
    }
  }
  static void getMDS() async {
    var url = 'http://$uri/mds';
    var response = await http.get(Uri.parse(url));
    if(response.statusCode != 200) {
      throw Exception('Failed to get MDS');
    }
    
    String filename = response.headers['filename']?? 'mds.xlsm';
    await FileSaver.instance.saveFile(name: filename, bytes: response.bodyBytes, customMimeType: response.headers['media_type']);

    print(response.headers);
    print('MDS downloaded');
  }


}