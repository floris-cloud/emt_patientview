// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'emt_patientview';

  @override
  String get newPatient => 'Neuer Patient';

  @override
  String get allPatients => 'Alle Patienten';

  @override
  String get patientData => 'Patientendaten';

  @override
  String get settings => 'Einstellungen';

  @override
  String get switchLanguage => 'Deutsch';

  @override
  String get switchTheme => 'Nachtmodus';

  @override
  String get allPatientsTitle => 'Alle Patienten';

  @override
  String get mainDiagnose => 'Hauptdiagnose';

  @override
  String get otherDiagnose => 'Weitere Diagnosen';

  @override
  String get anamnese => 'Anamnese';

  @override
  String enterProtocol(Object patientPrename) {
    return 'Geben Sie das Protokoll für $patientPrename ein';
  }

  @override
  String get notes => 'Notizen';

  @override
  String get medicalValues => 'Messwerte';

  @override
  String get bloodPressure => 'Blutdruck in mmHg: ';

  @override
  String get nibp => 'NIBP';

  @override
  String get mmHg => 'mmHg';

  @override
  String get systolic => 'Systolisch';

  @override
  String get diastolic => 'Diastolisch';

  @override
  String get respiratoryRate => 'Atemfrequenz';

  @override
  String get pulse => 'Puls';

  @override
  String get oxygenSaturation => 'Sauerstoffsättigung';

  @override
  String get temperature => 'Temperatur in °C';

  @override
  String get bloodSugar => 'Blutzucker in mg/dl';

  @override
  String get submit => 'Absenden';

  @override
  String get patientInputTitle => 'Patienteneingabe';

  @override
  String get birthdate => 'Geburtsdatum';

  @override
  String get prename => 'Vorname';

  @override
  String get surname => 'Nachname';

  @override
  String get addPatient => 'Patient hinzufügen';

  @override
  String get changePatient => 'Patientendaten ändern';

  @override
  String get errorNotNumeric => 'Bitte gebe eine Zahl ein';

  @override
  String get errorNoText => 'Bitte gebe einen Text ein';

  @override
  String get errorDisGreaterSys => 'Die Systole muss größer als die Diastole sein';

  @override
  String get noPatients => 'Keine Patienten vorhanden';

  @override
  String get noTriageCategory => 'Keine Triage-Kategorie';

  @override
  String get emergency => 'Notfall';

  @override
  String get veryUrgent => 'sehr drigend';

  @override
  String get urgent => 'drigend';

  @override
  String get normal => 'normal';

  @override
  String get noUrgent => 'keine Dringlichkeit';

  @override
  String get search => 'Suche';

  @override
  String get noData => 'keine Daten';

  @override
  String get waitingArea => 'Wartbereich';

  @override
  String get noPatientsFound => 'Keine Patienten gefunden';

  @override
  String get dragPatientHere => 'Ziehe Patienten hierher';

  @override
  String get close => 'Schließen';

  @override
  String get phone => 'Telefon';

  @override
  String get email => 'E-Mail';

  @override
  String get fax => 'Fax';

  @override
  String get sms => 'SMS';

  @override
  String get other => 'Andere';

  @override
  String get diagnose => 'Diagnose';

  @override
  String get sortTimeDesc => 'Zeit absteigend';

  @override
  String get sortTimeAsc => 'Zeit aufsteigend';

  @override
  String get sortAlphabeticalAsc => 'Alphabetisch aufsteigend';

  @override
  String get sortAlphabeticalDesc => 'Alphabetisch absteigend';

  @override
  String get sortUrgency => 'Dringlichkeit';

  @override
  String get filterNoTreatmentStation => 'Patienten ohne Behandlungsstation';

  @override
  String get filterTreatmentStation => 'Patienten mit und ohne Behandlungsstation';

  @override
  String get filterInactive => 'Nur aktive Patienten';

  @override
  String get filterNoInactive => 'Inaktive Patienten anzeigen';

  @override
  String get arrivedAt => 'Aaufnahme um';

  @override
  String get discharge => 'Entlassen';

  @override
  String get noPatientSelected => 'Kein Patient ausgewählt';

  @override
  String get addAnamnese => 'Add anamnese';

  @override
  String get finalProtocol => 'Protokoll abschließen';

  @override
  String get overView => 'Gesamtübersicht';

  @override
  String get firstContact => 'Erstkontakt';

  @override
  String get lastContact => 'Letzter Kontakt';

  @override
  String get allProtocolls => 'Alle Protokolle';

  @override
  String get downloadProtocol => 'Protokoll herunterladen';

  @override
  String get treatmentStations => 'Behandlungsstationen';
}
