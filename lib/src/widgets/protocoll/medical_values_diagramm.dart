import 'package:emt_patientview/src/models/patient.dart';
import 'package:flutter/material.dart';

import '../../models/medical_values.dart';

class MedicalValuesDiagramm extends StatelessWidget{
  final Patient patient;
  MedicalValuesDiagramm({super.key, required this.patient});

  @override
   Widget build(BuildContext context) {
    List<MedicalValues> medicalValuesList = patient.protocls!.last.medicalValuesList;
    print(medicalValuesList[0].toJson());
    return Container(
      child: Text('MedicalValuesDiagramm'),
    );
  }
}