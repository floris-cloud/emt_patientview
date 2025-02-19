import 'dart:convert';

import 'icd.dart';
import 'medical_values.dart';


class Protocol {
  String patientId;
  String? notes;
  Icd? mainDiagnose;
  List<Icd> otherDiagnoses = [];

  List<MedicalValues> medicalValuesList;

  Protocol({
    required this.patientId,
     this.notes,
    List<MedicalValues>? medicalValuesList, this.mainDiagnose,
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
    Icd? mainDiagnose;
    if (medicalValuesList != null && medicalValuesList is List) {
      valuesList = medicalValuesList.map((item) {
        return MedicalValues.fromMap(item);
      }).toList();
    }
    if (map['mainDiagnose'] != null) {
      mainDiagnose = Icd.fromJson(jsonDecode(map['mainDiagnose']));
    }
    return Protocol(
      patientId: map['patientId'],
      notes: map['notes'],
      medicalValuesList: valuesList,
      mainDiagnose: mainDiagnose,
      );
  }
}

