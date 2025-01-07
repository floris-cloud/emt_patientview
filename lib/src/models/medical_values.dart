
class MedicalValues {
  int? systolic;
  int? diastolic;
  int? respiratoryRate;
  int? pulse;
  double? oxygenSaturation;
  double? temperature;
  double? bloodSugar;
  DateTime createdAt;

  MedicalValues({
    this.systolic,
    this.diastolic,
    this.respiratoryRate,
    this.pulse,
    this.oxygenSaturation,
    this.temperature,
    this.bloodSugar,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'systolic': systolic,
      'diastolic': diastolic,
      'respiratoryRate': respiratoryRate,
      'pulse': pulse,
      'oxygenSaturation': oxygenSaturation,
      'temperature': temperature,
      'bloodSugar': bloodSugar,
      'medicalValuesAdded': createdAt.toIso8601String(),
    };
  }

  factory MedicalValues.fromMap(Map<String, dynamic> map) {
    return MedicalValues(
      systolic: map['systolic'],
      diastolic: map['diastolic'],
      respiratoryRate: map['respiratoryRate'],
      pulse: map['pulse'],
      oxygenSaturation: map['oxygenSaturation'],
      temperature: map['temperature'],
      bloodSugar: map['bloodSugar'],
      createdAt: DateTime.tryParse(map['medicalValuesAdded'])
          ?? DateTime.now(),

    );
  }

  static fromJson(Map<String, dynamic> json) {
    return MedicalValues(
      systolic: json['systolic'] as int,
      diastolic: json['diastolic'] as int,
      respiratoryRate: json['respiratoryRate'] as int,
      pulse: json['pulse'] as int,
      oxygenSaturation: json['oxygenSaturation'] as double,
      temperature: json['temperature'] as double,
      bloodSugar: json['bloodSugar'] as double,
      createdAt: DateTime.tryParse(json['medicalValuesAdded'] as String)
          ?? DateTime.now(),
    );
  }
}
