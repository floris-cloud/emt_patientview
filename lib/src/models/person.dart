import 'package:flutter/material.dart';


class Person {
  String preName;
  String surName;
  DateTime birthDate;
  Gender gender;

  Person({
     DateTime? birthDate,
    required this.preName,
    required this.surName,
    required this.gender,
  }): birthDate= birthDate?? DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);


  Person.fromJson(Map<String, dynamic> json)
      : preName = json['preName'],
        surName = json['surName'],
        birthDate = DateTime.parse(json['birthDate']),
        gender = Gender.values.singleWhere((gender) => gender.toString() == json['gender']);

  Map<String, dynamic> toJson() => {
    'preName': preName,
    'surName': surName,
    'birthDate': birthDate.toIso8601String(),
    'gender': gender.toString(),
  };
   
}

enum Gender {
  male(name:"male", icon:Icons.male),
  female(name:"female", icon:Icons.female),
  other(name:"other", icon:Icons.transgender),
  unknown(name:"unkown",icon:Icons.question_mark);
  
  const Gender({
    required this.name,
    required this.icon
  });
  final String name;
  final IconData icon;
}
