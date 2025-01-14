// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';

import 'patient.dart';


class PatientListModel extends ChangeNotifier {



   List<Patient> _patients = [];


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
}
