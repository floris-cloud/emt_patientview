// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';

import '../repository/patient_repository.dart';
import 'triage_category.dart';
import 'patient.dart';


class PatientListModel extends ChangeNotifier {



   List<Patient> _patients = [];
   Set<TriageCategory> filterTriageCategory = TriageCategory.values.toSet();
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
  
  List<Patient> getFilteredPatients(bool filterNoTreatmentStation, bool filterInactive) {
    List<Patient> filterdPatients = [..._patients];
    if (filterInactive){
      filterdPatients.removeWhere((element) => element.active == false);
    }
    if (filterNoTreatmentStation) {
     filterdPatients.removeWhere((element) => element.treatmentStationId != null);
    }
   filterdPatients.removeWhere((element) => !filterTriageCategory.contains(element.triageCategory));
   return filterdPatients;
    
  }

  sortPatientsTimeAsc() {
    _patients.sort((a, b) => a.firstContact.compareTo(b.firstContact));
  }
    sortPatientsTimeDesc() {
    _patients.sort((a, b) => b.firstContact.compareTo(a.firstContact));

  }
  sortPatientsTriageCategoryAsc() {
    _patients.sort((a, b) => a.triageCategory.index.compareTo(b.triageCategory.index));

  }
  sortPatientsTriageCategoryDesc() {
    _patients.sort((a, b) => b.triageCategory.index.compareTo(a.triageCategory.index));

  }
  sortPatientsAlphabeticalAsc() {
    _patients.sort((a, b) => a.surName.compareTo(b.surName));

  }
  sortPatientsAlphabeticalDesc() {
    _patients.sort((a, b) => b.surName.compareTo(a.surName));

  }

}