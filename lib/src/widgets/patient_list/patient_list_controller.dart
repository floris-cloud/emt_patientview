import 'package:flutter/material.dart';
import '../../models/patient.dart';
import '../../repository/patient_repository.dart';

class PatientListController extends ChangeNotifier {
  List<Patient> _patients = [];

  List<Patient> get patients => _patients;

  PatientListController() {
    print("PatientListController");
    refreshPatients();
  }

  Future<void> _loadPatients() async {
    _patients = await PatientStorage.loadPatients();
    print(_patients.length);
    notifyListeners();
  }

  Future<void> refreshPatients() async {
    print("refreshing patients");
    await _loadPatients();
  }


  
}