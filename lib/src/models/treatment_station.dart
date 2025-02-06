import 'package:emt_patientview/src/models/patient.dart';
import 'package:flutter/material.dart';

class TreatmentStation extends ChangeNotifier {
  int id;
  String name;
  String? dbId;
  Patient? patient;
  Color? color;

  TreatmentStation({
    required this.id,
    required this.name,
    this.patient,
    this.color,
    this.dbId
  });
  factory TreatmentStation.fromJson(Map<String, dynamic> json) {
    
    return TreatmentStation(
        id: json["id"],
        name: json["name"],
        patient: json['patient'] == null ? null : Patient.fhirJson(json['patient']),
        color:  json['color'] == null ? null : Color(int.parse(json['color'])),
        dbId: json['dbId']==null ? null : json['dbId'],
  );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name
        // 'patient': patient?.toJson(),
        // 'color': color?.value,
      };
}