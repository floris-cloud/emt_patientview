import 'dart:convert';

import 'medical_values.dart';

class Protocol {
  String patientId;
  String notes;
  List<MedicalValues> medicalValuesList;

  Protocol({
    required this.patientId,
    required this.notes,
    List<MedicalValues>? medicalValuesList,
  }) : medicalValuesList = medicalValuesList ?? [];

  void addMedicalValues(MedicalValues values) {
    medicalValuesList.add(values);
  }

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'notes': notes,
      'medicalValuesList': medicalValuesList,
    };
  }

  factory Protocol.fromJson(String json) {
    return Protocol.fromMap(jsonDecode(json));
  }

  factory Protocol.fromMap(Map<String, dynamic> map) {
    var medicalValuesList = map['medicalValuesList'];
    List<MedicalValues> valuesList = [];
    if (medicalValuesList != null && medicalValuesList is List) {
      valuesList = medicalValuesList.map((item) {
        return MedicalValues.fromMap(item);
      }).toList();
    }
    return Protocol(
      patientId: map['patientId'],
      notes: map['notes'],
      medicalValuesList: valuesList,);
  }
}
