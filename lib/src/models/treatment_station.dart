import 'package:emt_patientview/src/models/patient.dart';
import 'package:flutter/material.dart';

class TreatmentStation extends ChangeNotifier {
  int id;
  String name;
  Patient? patient;
  Color? color;

  TreatmentStation({
    required this.id,
    required this.name,
    this.patient,
    this.color,
  });

}