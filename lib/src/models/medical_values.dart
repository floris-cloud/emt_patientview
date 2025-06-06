
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
  @override
@override
String toString() {
  String date = '${createdAt.hour}:${createdAt.minute} ${createdAt.day}.${createdAt.month}.${createdAt.year}';

  return [
  if (systolic != null || diastolic != null)
    'Systolic Blood Pressure: ${systolic ?? '-'} / ${diastolic ?? '-'} mmHg',
  if (respiratoryRate != null) 'Respiratory Rate: $respiratoryRate /min',
  if (pulse != null) 'Pulse: $pulse /min',
  if (oxygenSaturation != null) 'Oxygen Saturation: $oxygenSaturation %',
  if (temperature != null) 'Body Temperature: $temperature °C',
  if (bloodSugar != null) 'Blood Sugar Level: $bloodSugar mmol/L',
  'Date and Time of measurement: $date',
].join('\n');
  // return '''
  //   Systolic Blood Pressure: ${systolic ?? '-'} / ${diastolic ?? '-'} mmHg
  //   Respiratory Rate: ${respiratoryRate ?? '-'} /min
  //   Pulse: ${pulse ?? '-'} /min
  //   Oxygen Saturation: ${oxygenSaturation ?? '-'} %
  //   Body Temperature: ${temperature ?? '-'} °C
  //   Blood Sugar Level: ${bloodSugar ?? '-'} mmol/L
  //   Date and Time of measurement: $date
  // ''';
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
