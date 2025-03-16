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
  };

  @override
  String toString() {
    return 'Icd{title: $title, description: $description}';
  }

   dynamic mdsFromDiagnose(){
    List<String> icdMajorHeadInjury = ['NA00','NA01','NA02','NA03', 'NA06', 'NA08', 'NA09','NA0A'];
    if (icdMajorHeadInjury.any((prefix) => code.startsWith(prefix))){
      return MDSTrauma.majorExtremityInjury;
    }
    List<String> icdmajorTorsoInjury = [];
    if (icdmajorTorsoInjury.any((prefix) => code.startsWith(prefix))){
      return MDSTrauma.majorTorsoInjury;
    }
    List<String> icdmajorExtremityInjury = [];
    if (icdmajorExtremityInjury.any((prefix) => code.startsWith(prefix))){
      return MDSTrauma.majorExtremityInjury;
    }
    List<String> icdMadorateInjury = [];
    if (icdMadorateInjury.any((prefix) => code.startsWith(prefix))){
      return MDSTrauma.moderateInjury;
    }
    List<String> icdMinorInjury = [];
    if (icdMinorInjury.any((prefix) => code.startsWith(prefix))){
      return MDSTrauma.minorInjury;
    }

    return null;
  }
}