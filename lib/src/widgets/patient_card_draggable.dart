import 'package:emt_patientview/src/widgets/patient_card_widget.dart';
import 'package:flutter/material.dart';

import '../models/patient.dart';

class PatientCardDraggable extends StatelessWidget {
  final Patient patient;

  const PatientCardDraggable({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<Patient>(data:patient,child:  PatientCard(patient: patient), feedback: PatientCard(patient: patient));
  }
  
}