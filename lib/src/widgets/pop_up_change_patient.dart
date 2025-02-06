import 'package:emt_patientview/src/widgets/patient_change_user_journey.dart';
import 'package:flutter/material.dart';

import '../models/patient.dart';

class PopUpChangePatient extends StatelessWidget{
  Patient patient;
  PopUpChangePatient({required this.patient});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: PatientChangeUserJourney(patient: patient),
    );
  }
}