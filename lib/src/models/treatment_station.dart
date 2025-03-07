import 'package:emt_patientview/src/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../repository/patient_repository.dart';
class TreatmentStation extends ChangeNotifier {
  String idString = Uuid().v4();
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
    print(json);
    return TreatmentStation(
        id: json["id"],
        name: json["name"],
        patient: json['patientId'] == null ? null : json['patientId'],
        //color:  json['color'] == null ? null : Color(int.parse(json['color'].substring(1), radix: 16)),
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