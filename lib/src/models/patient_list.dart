// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';

import '../repository/patient_repository.dart';
import 'triage_category.dart';
import 'patient.dart';


class PatientListModel extends ChangeNotifier {



   List<Patient> _patients = [];
   Set<TriageCategory> filterTriageCategory = {};
  PatientListModel() {
    init();
  }

  init() async {
    _patients = await PatientStorage.loadPatients();
    notifyListeners();
  }
  List<Patient> get patients => _patients;

  set patient(List<Patient> newPatients) {
    _patients = newPatients;
    notifyListeners();
  }
  void add(Patient patient) {
    _patients.add(patient);
    PatientStorage.savePatient(patient);
    notifyListeners();
  }

  void remove(Patient patient) {
    _patients.remove(patient);
    notifyListeners();
  }
  void change(Patient patient) {
    _patients[_patients.indexWhere((element) => element.id == patient.id)] = patient;   
    PatientStorage.changePatient(patient);
    notifyListeners();
  }
  
  List<Patient> getFilteredPatients() {
    if (filterTriageCategory.isEmpty) {
      return _patients;
    } else {
      List<Patient> _filterdPatients =  _patients.where((element) => filterTriageCategory.contains(element.triageCategory)).toList();
      return _filterdPatients;
    }
  }
}