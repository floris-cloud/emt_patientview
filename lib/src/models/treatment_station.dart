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
    print(json);
    Color? color;
      if (json['color'] != null && json['color'].isNotEmpty) {
    String colorstring = json['color'].split("0x").last;
    int i = (int.parse(colorstring, radix: 16));
      color = Color(i);
      }
      print(json["id"]);
      print(json["name"]);
    return TreatmentStation(
        id: json["id"],
        name: json["name"],
        // patient: json['patientId'],
        color:  color,
        dbId: json['dbId'],
  );
  }

  //TODO add color
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dbId": dbId,
        "color": color != null 
        ? '0x${color!.toARGB32().toRadixString(16).padLeft(8, '0')}' 
        : null
        // 'patient': patient?.toJson(),
        // 'color': color?.value,
      };
}