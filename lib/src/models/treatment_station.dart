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
  factory TreatmentStation.fromJson(Map<String, dynamic> json) => TreatmentStation(
        id: json['id'],
        name: json['name'],
        patient: json['patient'] != null ? Patient.fhirJson(json['patient']) : null,
        color: json['color'] != null ? Color(json['color']) : null,
  );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'patient': patient?.toJson(),
        'color': color?.value,
      };
}