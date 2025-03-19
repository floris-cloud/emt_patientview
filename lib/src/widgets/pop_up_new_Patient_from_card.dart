import 'dart:convert';

import 'package:emt_patientview/src/models/patient.dart';
import 'package:emt_patientview/src/repository/patient_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/patient_list.dart';

class PopUpNewPatientFromCard  extends StatelessWidget{
  final String pateintData;
  PopUpNewPatientFromCard({required this.pateintData});
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = jsonDecode(pateintData);
    Patient patient = Patient.fhirJson(data);
    return AlertDialog(
      title: Text(patient.surName+ ", "+ patient.preName+ " Patienten anlegen"),
      content: Text("Möchten Sie wirklich einen neuen Patienten anlegen?"),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: Text('Nein')),
        TextButton(onPressed: () {
          PatientStorage.savePatient(patient);
          context.read<PatientListModel>().add(patient);
          Navigator.pop(context, 'OK');            
        } , child: Text('Ja')),
      ],
    );
  }
}