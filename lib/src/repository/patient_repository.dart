import 'dart:async';

import '../models/patient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PatientStorage {
  static const String _key = 'patient';

  static Future<void> savePatient(Patient patient) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Patient> patients = await loadPatients();
    print(100);
    patients.add(patient);
    String patientsJson = jsonEncode(patients);
    await prefs.setString(_key, patientsJson);
  }

  static Future<List<Patient>> loadPatients() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Patient> patients = [];
    String? patientsJson = prefs.getString(_key);
    if (patientsJson == null) {
      return [];
    }
    List<dynamic> patientListMap = jsonDecode(patientsJson!);
    for (dynamic patientMap in patientListMap) {
      patients.add(Patient.fromMap(patientMap));
    }
      return patients;
  }

  static Future<void> changePatient(Patient patient) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Patient> patients = await loadPatients();
    patients.removeWhere((p) => p.id == patient.id);
    patients.add(patient);
    String patientsJson = jsonEncode(patients);
    await prefs.setString(_key, patientsJson);
  }
}
