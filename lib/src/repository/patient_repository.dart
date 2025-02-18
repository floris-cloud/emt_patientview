import 'dart:async';

import 'package:provider/provider.dart';

import '../models/patient.dart';
import '../repository/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class PatientStorage {
  static const String _key = 'patient';

  static Future<void> savePatient(Patient patient) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Patient> patients = await loadPatients();
    patients.add(patient);
    await RestApi.postPatient(patient);
    String patientsJson = jsonEncode(patients);
    await prefs.setString(_key, patientsJson);
  }

  static Future<List<Patient>> loadPatients() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Patient> patients = [];
    
    List<Patient> patientList = await RestApi.getPatientList();
  
    String? patientsJson = prefs.getString(_key);
    
    if (patientsJson == null) {
      await prefs.setString(_key, jsonEncode(patientList));
      return patientList;
    }
    List<dynamic> patientListMap = jsonDecode(patientsJson);
    for (dynamic patientMap in patientListMap) {
      patients.add(Patient.fromMap(patientMap));
    }
      patientList.where((p) => !patients.any((patient) => patient.id == p.id)).forEach((p) => patients.add(p));
      return patients;
  }

  static Future<void> changePatient(Patient patient) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Patient> patients = await loadPatients();
    patients.removeWhere((p) => p.id == patient.id);
    patients.add(patient);
    RestApi.changePatient(patient);
    String patientsJson = jsonEncode(patients);
    await prefs.setString(_key, patientsJson);
  }
}
