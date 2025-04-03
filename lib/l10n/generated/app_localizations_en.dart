// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'emt_patientview';

  @override
  String get newPatient => 'new Patient';

  @override
  String get allPatients => 'all Patients';

  @override
  String get patientData => 'patient data';

  @override
  String get settings => 'Settings';

  @override
  String get switchLanguage => 'English';

  @override
  String get switchTheme => 'Nightmode';

  @override
  String get allPatientsTitle => 'All Patients';

  @override
  String get mainDiagnose => 'main diagnose';

  @override
  String get otherDiagnose => 'other diagnose';

  @override
  String get anamnese => 'anamnese';

  @override
  String enterProtocol(Object patientPrename) {
    return 'Enter Protocol for $patientPrename';
  }

  @override
  String get notes => 'Notes';

  @override
  String get medicalValues => 'medical values';

  @override
  String get bloodPressure => 'Bloodpressure in mmHg: ';

  @override
  String get nibp => 'NIBP';

  @override
  String get mmHg => 'mmHg';

  @override
  String get systolic => 'Systolic';

  @override
  String get diastolic => 'Diastolic';

  @override
  String get respiratoryRate => 'Respiratory Rate';

  @override
  String get pulse => 'Pulse';

  @override
  String get oxygenSaturation => 'Oxygene Saturation';

  @override
  String get temperature => 'Temperature in °C';

  @override
  String get bloodSugar => 'Blood Sugar in mg/dl';

  @override
  String get submit => 'Submit';

  @override
  String get patientInputTitle => 'Patient Input';

  @override
  String get birthdate => 'birthdate';

  @override
  String get prename => 'prename';

  @override
  String get surname => 'surname';

  @override
  String get addPatient => 'Add Patient';

  @override
  String get changePatient => 'Change patient Data';

  @override
  String get errorNotNumeric => 'Enter a Number';

  @override
  String get errorNoText => 'Please enter a Text';

  @override
  String get errorDisGreaterSys => 'Diastol can not be greater then Systol';

  @override
  String get noPatients => 'No Patients';

  @override
  String get noTriageCategory => 'No Triage Category';

  @override
  String get emergency => 'emergency';

  @override
  String get veryUrgent => 'very urgent';

  @override
  String get urgent => 'urgent';

  @override
  String get normal => 'normal';

  @override
  String get noUrgent => 'no urgent';

  @override
  String get search => 'search';

  @override
  String get noData => 'no data';

  @override
  String get waitingArea => 'waiting area';

  @override
  String get noPatientsFound => 'No patients found';

  @override
  String get dragPatientHere => 'Drag patient here';

  @override
  String get close => 'close';

  @override
  String get phone => 'phone';

  @override
  String get email => 'e-email';

  @override
  String get fax => 'fax';

  @override
  String get sms => 'sms';

  @override
  String get other => 'other';

  @override
  String get diagnose => 'diagnose';

  @override
  String get sortTimeDesc => 'Time descending';

  @override
  String get sortTimeAsc => 'Time ascending';

  @override
  String get sortAlphabeticalAsc => 'Alphabetical ascending';

  @override
  String get sortAlphabeticalDesc => 'Alphabetical descending';

  @override
  String get sortUrgency => 'Urgency';

  @override
  String get filterNoTreatmentStation => 'Patients without treatment station';

  @override
  String get filterTreatmentStation => 'Patients with and without treatment station';

  @override
  String get filterInactive => 'Only active patients';

  @override
  String get filterNoInactive => 'Show inactive patients';

  @override
  String get arrivedAt => 'Arrived at';

  @override
  String get discharge => 'discharge';

  @override
  String get noPatientSelected => 'No patient selected';

  @override
  String get addAnamnese => 'Add anamnese';

  @override
  String get finalProtocol => 'send protocol';

  @override
  String get overView => 'Overview';

  @override
  String get firstContact => 'first Contact';

  @override
  String get lastContact => 'last contact';

  @override
  String get allProtocolls => 'all protocolls';

  @override
  String get downloadProtocol => 'download protocol';

  @override
  String get treatmentStations => 'treatmentstations';
}
