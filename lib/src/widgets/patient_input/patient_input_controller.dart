import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/patient.dart';
import '../../models/person.dart';
import '../../models/triage_category.dart';
import '../../repository/patient_repository.dart';
import '../patient_list/patient_list_controller.dart';

class PatientInputController with ChangeNotifier {
  final preNameController = TextEditingController();
  final surNameController = TextEditingController();
  final ageController = TextEditingController();
  final birthDateController = TextEditingController();
  Gender gender = Gender.male;
  int triageCategory = 1;

  


  Patient createPatient() {
      Patient patient = Patient(
      surName: surNameController.text,
      preName: preNameController.text,
      birthDate: DateTime.tryParse(birthDateController.text) ?? DateTime.now(),
      gender: gender,
      triageCategory: TriageCategory(triageCategory),
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
