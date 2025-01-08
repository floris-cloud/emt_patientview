import 'package:flutter/material.dart';
import '../../models/patient.dart';
import '../../models/person.dart';
import '../../models/triage_category.dart';
import '../../repository/patient_repository.dart';

class PatientInputController with ChangeNotifier {
  final preNameController = TextEditingController();
  final surNameController = TextEditingController();
  final ageController = TextEditingController();
  final birthDateController = TextEditingController();
  Gender gender = Gender.male;
  int triageCategory = 1;

  




  Future<void> savePatient() async {
    Patient patient = Patient(
      surName: surNameController.text,
      preName: preNameController.text,
      birthDate: DateTime.tryParse(birthDateController.text) ?? DateTime.now(),
      gender: gender,
      triageCategory: TriageCategory(triageCategory),
    );
    await PatientStorage.savePatient(patient);

  }

  void setGender(Gender newGender) {
    gender = newGender;
    notifyListeners();
  }

  void setTriageCategory(int newCategory) {
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
