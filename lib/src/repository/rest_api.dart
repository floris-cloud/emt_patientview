import 'dart:convert';
import 'package:file_saver/file_saver.dart';
import 'package:http/http.dart' as http;
import '../models/patient.dart';
import '../models/protocol.dart';
import '../models/treatment_station.dart';

class RestApi {
  // static String uri = 'localhost:8020';
  static String uri = 'floris-20df0051ge.local:8020';
  // static String uri = 'api';
  

  static Future<List<Patient>> getPatientList() async {
    var url = 'http://$uri/patients';
    try {
    var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
      List<Patient> patients = [];
      List<dynamic> json = jsonDecode(response.body);
      
      json.forEach((jsonP) async {
        // List<Protocol> protocols = await RestApi.getProtocolsbyId(jsonP['id']);
        patients.add(Patient.fromMap(jsonP));
        });
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
  var response = await http.post(Uri.parse(url), body: jsonEncode(ts.toJson()));
  if(response.statusCode != 200) {
    throw Exception('Failed to post TreatmentStation');
  }
}
static Future<List<TreatmentStation>> getTreatmentStations() async {
  var url = 'http://$uri/treatmentStation';
  try {
    
  
  var response = await http.get(Uri.parse(url));
  if(response.statusCode != 200) {
    return [];
  }
  List<TreatmentStation> treatmentStations = [];
  List<dynamic> json = jsonDecode(response.body);
  if(json.isEmpty) {
    return treatmentStations;
  }
  for (var jsonP in json) {
    treatmentStations.add(TreatmentStation.fromJson(jsonDecode(jsonP)));
    }

  return treatmentStations;
  }
  catch(e){
    return [];
  }
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
  // static Future<List<Protocol>> getProtocols(Patient patient) async {
  //   var url = 'http://$uri/protocol/';
  //   var request = http.Request('GET', Uri.parse(url));
  //   request.body = patient.id;
  //   var response = await request.send();
  //   if(response.statusCode != 200) {
  //     throw Exception('Failed to get Protocol');
  //   }
  //   List<Protocol> protocols = [];
  //   List<dynamic> json = jsonDecode(response.stream.toString());
  //   for (var jsonP in json) {protocols.add(Protocol.fromMap(jsonP));}
  //   return protocols;
  // }

   static Future<List<Protocol>> getProtocolsbyId(String id) async {
    var url = Uri.parse('http://$uri/protocol/?id=$id'); 
  final response = await http.get(url); 
  if (response.statusCode != 200) {
    throw Exception('Failed to get Protocol: ${response.statusCode}');
  }
      List<Protocol> protocols = [];
      var jsondecoded = jsonDecode(jsonDecode(response.body));
    for (var jsonP in jsondecoded) {protocols.add(Protocol.fromMap(jsonP));}
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
  }


}