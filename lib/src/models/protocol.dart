import 'dart:convert';

import 'package:emt_patientview/src/models/mds.dart';

import '../repository/protocol_repository.dart';
import 'icd.dart';
import 'medical_values.dart';


class Protocol {
  String patientId;
  String? notes;
  Icd? mainDiagnose;
  List<Icd> otherDiagnoses = [];

  List<MedicalValues> medicalValuesList;
  MDS? mds;
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
      'mds': mds?? [],
      'mainDiagnose': mainDiagnose??' ',
      'otherDiagnoses': otherDiagnoses,
      'timeStamp': DateTime.now().toIso8601String(),
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

  void sendProtocol() {
    ProtocolRepository.saveProtocol(this);
    // send protocol to server
  }
}

