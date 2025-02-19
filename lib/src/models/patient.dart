import 'dart:async';
import 'dart:io';
import 'package:fhir/r4.dart' as r4;
import 'package:uuid/uuid.dart';
import 'protocol.dart';
import 'triage_category.dart';
import 'person.dart';

class Patient extends Person {
   String? diagnose;
  final String id;
  TriageCategory triageCategory;
  final DateTime firstContact;
   bool timeExpired = false;
  int? treatmentStationId;
  List<r4.ContactPoint> contactPoints = [];
  bool active = true;
  List<Protocol>? protocls;
  DateTime? lastContact;
  
  Patient(
      {String? id,
      DateTime? firstContact,
      List<Protocol>? protocls,
      this.diagnose = "",
      required super.surName,
      required super.preName,
      super.birthDate,
      required super.gender,
      required this.triageCategory,})
      : id = id ?? const Uuid().v4(),
        firstContact = firstContact ?? DateTime.now();

  factory Patient.fromMap(Map<String, dynamic> map) {
    Patient p = Patient(
      preName: map['preName'],
      surName: map['surName'],
      birthDate: DateTime.parse(map['birthDate']),
      gender: Gender.values.byName('male'),
      diagnose: map['diagnose'],
      id: map['id'],
      triageCategory: TriageCategory.values.byName(map['triageCategory']),
      firstContact: DateTime.tryParse(map['firstContact']) ?? DateTime.now(),
    );

    p.timer(() {
    });
    return p;
  }
  factory Patient.fhirJson(Map<String, dynamic> json) {
    print(json);
    Patient p = Patient(
      preName: json['name'][0]['given'][0],
      surName: json['name'][0]['family'],
      gender: Gender.unknown,
      id: json['id'],
      triageCategory: TriageCategory.emergency,
      firstContact: DateTime.now(),
    );
    return p;
    
  }
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();
    map['diagnose'] = diagnose ?? '';
    map['id'] = id;
    map['triageCategory'] = triageCategory.name;
    map['firstContact'] = firstContact.toIso8601String();
    return map;
  }


  set patTriageCategory(TriageCategory triageCategory) {
    triageCategory = triageCategory;
  }

  set patTreatmentStationId(int? id) {
    treatmentStationId = id;
  }
  Timer timer(Function callback) {
    return Timer(
      firstContact
          .add(triageCategory.getDuration())
          .difference(DateTime.now()), () {
            callback();
          }
    );
  }
  addContactPoint(r4.ContactPointSystem system, String value, ){
    contactPoints.add(r4.ContactPoint(system: system,value: value));
  }
  getAge() {
    return DateTime.now().difference(birthDate).inDays ~/ 365;
  }

 String formatedBirthDate() {
    
    return "${birthDate.day.toString().padLeft(2, '0')}.${birthDate.month.toString().padLeft(2, '0')}.${birthDate.year}";
  }

  String formatedFirstContact() { 
    // return "${firstContact.day.toString().padLeft(2, '0')}"+" "+ "${firstContact.hour.toString().padLeft(2, '0')}:${firstContact.minute.toString().padLeft(2, '0')}";
    return "${firstContact.day.toString().padLeft(2, '0')}${firstContact.hour.toString().padLeft(2, '0')}${firstContact.minute.toString().padLeft(2, '0')}";
  }



  r4.Patient getFhirPatient() {
    return r4.Patient(
      fhirId: id,
      telecom: contactPoints ,
      name: [
        r4.HumanName(
          
          family: surName.isEmpty? 'unkown': surName,
          given: preName.isEmpty? ['unkown'] : [preName],
        ),
      ],

      birthDate: r4.FhirDate(birthDate.toIso8601String().split('T').first),
      gender: _getFhirGender(),
      active: r4.FhirBoolean(active),
    );
  }

  r4.FhirCode _getFhirGender() {
    switch (gender) {
      case Gender.male:
        return r4.FhirCode('male');
      case Gender.female:
        return r4.FhirCode('female');
      case Gender.other:
        return r4.FhirCode('other');
      case Gender.unknown:
      default:
        return r4.FhirCode('unkown');
    }
  }
}



