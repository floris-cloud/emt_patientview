import 'mds.dart';
class Icd {
  String title;
  String description;
  String entity;
  String code;

  Icd({required this.title, required this.description, required this.entity, required this.code});

  factory Icd.fromJson(Map<String, dynamic> json) {
    return Icd(
      title: json['title'],
      description: json['description'],
      entity: json['entity'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'entity': entity,
    'code': code
  };

  @override
  String toString() {
    return 'Icd{title: $title, description: $description}';
  }


  dynamic mdsFromDiagnose() {
  Map<List<String>, dynamic> icdMap = {
     ['NA01','NA02','NA03', 'NA06', 'NA08', 'NA09','NA0A']: MDSTrauma.majorHeadSpineInjury,
    []: MDSTrauma.majorTorsoInjury,
    []: MDSTrauma.majorExtremityInjury,
    ['NA00']: MDSTrauma.moderateInjury,
    []: MDSTrauma.minorInjury,
    []: MDSInfection.acuteRespiratoryInfection,
    ['ME05.1','1A40']: MDSInfection.acuteWateryDiarrhea,
    []: MDSInfection.acuteBloodyDiarrhea,
    []: MDSInfection.acuteIaundiceSyndrome,
    []: MDSInfection.suspectedMeasles,
    []: MDSInfection.suspectedMeningitis,
    ['1C13']: MDSInfection.suspectedTetanus,
    ['1A40', 'SM37']: MDSInfection.acuteFlaccidParalysis,
    []: MDSInfection.acuteHaemorrhagicFever,
    ['MG26']: MDSInfection.feverUnknownOrigin,
    []: MDSEmergency.surgicalEmergencyNonTrauma,
    []: MDSEmergency.medicalEmergencyNonInfectious,
    []: MDSOtherKeydiseases.skinDisease,
    []: MDSOtherKeydiseases.acuteMentalHealth,
    []: MDSOtherKeydiseases.obstetricComplication,
    []: MDSOtherKeydiseases.severeAcuteMalnutrition,
    []: MDSOtherKeydiseases.otherDiagnosis,
    []: MDSProtection.vulnerableChild,
    []: MDSProtection.vulnerableAdult,
    []: MDSProtection.sexualGenderBasedViolence,
    []: MDSProtection.violenceNonSGBV,
  };

  for (var entry in icdMap.entries) {
    if (entry.key.any((prefix) => code.startsWith(prefix))) {
      return entry.value;
    }
  }

  return null;
}
}