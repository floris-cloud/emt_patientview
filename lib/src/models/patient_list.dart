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

  // set patient(List<Patient> newPatients) {
  //   _patients = newPatients;
  //   notifyListeners();
  // }
  Future<void> add(Patient patient) async {
    _patients.add(patient);
    notifyListeners();
    await PatientStorage.savePatient(patient);
  }

  // void remove(Patient patient) {
  //   _patients.remove(patient);
  //   notifyListeners();
  // }
  void change(Patient patient) {
    _patients[_patients.indexWhere((element) => element.id == patient.id)] = patient;   
    notifyListeners();
    PatientStorage.changePatient(patient);
  }
  
  List<Patient> filteredPatients(bool filterNoTreatmentStation, {bool filterInactive=true}) {
    List<Patient> filterdPatients = [..._patients];
    if (filterInactive){
      filterdPatients.removeWhere((element) => element.active == false);
    }
    if (filterNoTreatmentStation) {
     filterdPatients.removeWhere((element) => element.treatmentStationId != null);
    }
    // filterdPatients.removeWhere((element) => !filterTriageCategory.contains(element.triageCategory));
   return filterdPatients;
    
  }

  sortPatientsTimeAsc() {
    _patients.sort((a, b) => a.protocls.last.createdAt.compareTo(b.protocls.last.createdAt));
  }
    sortPatientsTimeDesc() {
    _patients.sort((a, b) => b.protocls.last.createdAt.compareTo(a.protocls.last.createdAt));

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

  List<Patient> getFilteredPatients(String text) {
   
    List<Patient> _inactivePatients = [..._patients];
    _inactivePatients.removeWhere((element) => element.active == true);
    return _inactivePatients.where((element) => element.surName.toLowerCase().contains(text.toLowerCase()) || element.preName.toLowerCase().contains(text.toLowerCase())).toList();
  }

}