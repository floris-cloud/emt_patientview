import 'dart:async';
import 'package:uuid/uuid.dart';
import 'triage_category.dart';
import 'person.dart';

class Patient extends Person {
   String? diagnose;
  final String id;
    TriageCategory triageCategory;
  final DateTime firstContact;
   bool timeExpired = false;

  Patient(
      {String? id,
      DateTime? firstContact,
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
      triageCategory: TriageCategory(map['triageCategory']),
      firstContact: DateTime.tryParse(map['firstContact']) ?? DateTime.now(),
    );

    p.timer(() {
    });
    return p;
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();
    map['diagnose'] = diagnose ?? '';
    map['id'] = id;
    map['triageCategory'] = triageCategory.triageCategory;
    map['firstContact'] = firstContact.toIso8601String();
    return map;
  }


  setTriageCategory(int triageInt) {
    triageCategory = TriageCategory(triageInt);
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

  getAge() {
    return DateTime.now().difference(birthDate).inDays ~/ 365;
  }

 String formatedBirthDate() {
    
    return "${birthDate.day.toString().padLeft(2, '0')}.${birthDate.month.toString().padLeft(2, '0')}.${birthDate.year}";
  }
}
