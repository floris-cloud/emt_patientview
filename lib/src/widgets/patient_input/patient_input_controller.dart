import 'package:emt_patientview/src/models/treatment_station.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/patient.dart';
import '../../models/person.dart';
import '../../models/triage_category.dart';
import '../../repository/patient_repository.dart';

class PatientInputController with ChangeNotifier {

  final preNameController = TextEditingController();
  final surNameController = TextEditingController();
  final ageController = TextEditingController();
  final birthDateController = TextEditingController();
  Gender gender = Gender.unknown;
  TriageCategory triageCategory = TriageCategory.veryUrgent;

  


  Patient createPatient() {
      Patient patient = Patient(
      surName: surNameController.text,
      preName: preNameController.text,
      birthDate: DateTime.tryParse(birthDateController.text) ?? DateTime.now(),
      gender: gender,
      triageCategory: triageCategory,
    );
    return patient;
  }

  Future<void> savePatient() async {
     Patient patient = createPatient();
     await PatientStorage.savePatient(patient);

  }

  void setGender(Gender newGender) {
    gender = newGender;
    notifyListeners();
  }

  void setTriageCategory(TriageCategory newCategory) {
    triageCategory = newCategory;
    notifyListeners();
  }
  
  Future<void> selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
        birthDateController.text =
            selectedDate.toLocal().toString().split(' ')[0];
      notifyListeners();
    }
  }
 
  }
