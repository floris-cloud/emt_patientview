import 'package:fhir/r4.dart' as r4;
import 'package:uuid/uuid.dart';
import 'protocol.dart';
import 'triage_category.dart';
import 'person.dart';

class Patient extends Person {
  final String id;
  TriageCategory triageCategory;
  int? treatmentStationId;
  List<r4.ContactPoint> contactPoints = [];
  bool active;
  List<Protocol> protocls;
  Patient(
      {String? id,
      // DateTime? firstContact,
      List<Protocol>? protocls,
      this.active = true,
      required super.surName,
      required super.preName,
      super.birthDate,
      required super.gender,
      required this.triageCategory,})
      : id = id ?? const Uuid().v4(),
      protocls = protocls ?? [Protocol(patientId: id!, createdAt: DateTime.now())];
        // firstContact = firstContact ?? DateTime.now();
  //TODO wie bei toJSON
  factory Patient.fromMap(Map<String, dynamic> map) {
    Patient p = Patient(
      preName: map['preName'],
      surName: map['surName'],
      active: map['active'],
      birthDate: DateTime.parse(map['birthDate']),
      gender: Gender.values.byName('male'),
      id: map['id'],
      triageCategory: TriageCategory.values.byName(map['triageCategory']),
      protocls: Protocol.protocolListfromMap(map['protocls']),
    );
    return p;
  }
  factory Patient.fhirJson(Map<String, dynamic> json) {
    Patient p = Patient(
      preName: json['name'][0]['given'][0],
      surName: json['name'][0]['family'],
      gender: Gender.unknown,
      id: json['id'],
      birthDate: DateTime.tryParse(json['birthDate']),
      triageCategory: TriageCategory.noTriageCategory,
    );
    return p;
    
  }
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();
    map['id'] = id;
    map['triageCategory'] = triageCategory.name;
    map['treatmentStationId'] = treatmentStationId;
    map['active'] = active;
    map['protocls'] = protocls.map((e) => e.toJson()).toList();
    return map;
  }


  set patTriageCategory(TriageCategory triageCategory) {
    triageCategory = triageCategory;
  }

  set patTreatmentStationId(int? id) {
    treatmentStationId = id;
  }
  addContactPoint(r4.ContactPointSystem system, String value, ){
    contactPoints.add(r4.ContactPoint(system: system,value: value));
  }
  discharge(){
    active = false;
    treatmentStationId = null;
    protocls.last.addContact("discharged");
  }

  getAge() {
    return DateTime.now().difference(birthDate).inDays ~/ 365;
  }

 String formatedBirthDate() {
    
    return "${birthDate.day.toString().padLeft(2, '0')}.${birthDate.month.toString().padLeft(2, '0')}.${birthDate.year}";
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



