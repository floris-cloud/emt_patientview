import 'package:flutter/material.dart';

import '../../models/patient.dart';

class PatientInformation extends StatelessWidget{
  final Patient patient;
  PatientInformation({super.key, required this.patient});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
                    patient.id.split('-').first,
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                  Text(
                    patient.surName+", "+patient.preName,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              
                  Text(
                    patient.formatedBirthDate(),
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[700],
                    ),
                  ),Icon(patient.gender.icon, color: Colors.black,),
      ]
    );
  }
}