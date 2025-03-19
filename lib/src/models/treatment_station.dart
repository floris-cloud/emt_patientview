import 'package:emt_patientview/src/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
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
    String colorstring = json['color'].split("0x").last;
    int i = (int.parse(colorstring, radix: 16));
    return TreatmentStation(
        id: json["id"],
        name: json["name"],
        patient: json['patientId'],
        color:  json['color'] == null ? null :  Color(i),
        dbId: json['dbId'],
  );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name
        // 'patient': patient?.toJson(),
        // 'color': color?.value,
      };
}