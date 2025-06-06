import 'dart:convert';

import 'package:emt_patientview/src/models/mds.dart';
import 'package:emt_patientview/src/models/triage_category.dart';

import '../repository/protocol_repository.dart';
import 'icd.dart';
import 'medical_values.dart';


class Protocol {
  String patientId;
  String? notes;
  Icd? mainDiagnose;
  List<Icd> otherDiagnoses = [];
  DateTime createdAt;
  List<MedicalValues> medicalValuesList;
  MDS? mds;
  Map<DateTime, dynamic> contacts = {};
 Protocol({
    required this.patientId,
    DateTime? createdAt,
    this.notes,
    List<MedicalValues>? medicalValuesList,
    this.mainDiagnose,
  }) : 
    createdAt = createdAt ?? DateTime.now(),
    medicalValuesList = medicalValuesList ?? [];

  void addMedicalValues(MedicalValues values) {
    medicalValuesList.add(values);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> contactsString = contacts.map((key, value) => MapEntry(key.toIso8601String(), value is TriageCategory ? value.name : value));
    return {
      'patientId': patientId,
      'notes': notes,
      'medicalValuesList': medicalValuesList,
      'mds': mds?? [],
      'mainDiagnose': mainDiagnose??' ',
      'otherDiagnoses': otherDiagnoses,
      'firstContact': createdAt.toIso8601String(),
      'contacts' : contactsString,
      'timeStamp': DateTime.now().toIso8601String()
    };
  }

  factory Protocol.fromJson(String json) {
    return Protocol.fromMap(jsonDecode(json));
  }
  factory Protocol.fromMap(Map<String, dynamic> map) {
  final medicalValuesList = map['medicalValuesList'] as List? ?? [];
  final valuesList = medicalValuesList
      .map((item) => MedicalValues.fromMap(item as Map<String, dynamic>))
      .toList();

  Icd? mainDiagnose;
  // if (map['mainDiagnose'] is Map<String, dynamic>) {
  //   mainDiagnose = Icd.fromJson(map['mainDiagnose'] as Map<String, dynamic>);
  // }
  final otherDiagnoses = (map['otherDiagnoses'] as List? ?? [])
      .map((e) => Icd.fromJson(e as Map<String, dynamic>))
      .toList();

  Protocol p =  Protocol(
    patientId: map['patientId'] as String,
    notes: map['notes'] as String?,
    medicalValuesList: valuesList,
    mainDiagnose: mainDiagnose
    );
   
    p.contacts = (map['contacts'] as Map<String, dynamic>).map((key, value) => MapEntry(DateTime.parse(key), value));
    
  p.otherDiagnoses = otherDiagnoses;
  return p;
}

  void addContact(String value) {
    contacts[DateTime.now()] = value;
  }
  void sendProtocol() {
    ProtocolRepository.saveProtocol(this);
  }

  static List<Protocol>  protocolListfromMap(List<dynamic> list) {
    List<Protocol> protocols = [];
    for(var protocolMap in list){
      protocols.add(Protocol.fromMap(protocolMap));
    }
    return protocols;
  }
}

