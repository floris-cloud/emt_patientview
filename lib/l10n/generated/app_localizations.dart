import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'emt_patientview'**
  String get appTitle;

  /// No description provided for @newPatient.
  ///
  /// In en, this message translates to:
  /// **'new Patient'**
  String get newPatient;

  /// No description provided for @allPatients.
  ///
  /// In en, this message translates to:
  /// **'all Patients'**
  String get allPatients;

  /// No description provided for @patientData.
  ///
  /// In en, this message translates to:
  /// **'patient data'**
  String get patientData;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @switchLanguage.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get switchLanguage;

  /// No description provided for @switchTheme.
  ///
  /// In en, this message translates to:
  /// **'Nightmode'**
  String get switchTheme;

  /// No description provided for @allPatientsTitle.
  ///
  /// In en, this message translates to:
  /// **'All Patients'**
  String get allPatientsTitle;

  /// No description provided for @mainDiagnose.
  ///
  /// In en, this message translates to:
  /// **'main diagnose'**
  String get mainDiagnose;

  /// No description provided for @otherDiagnose.
  ///
  /// In en, this message translates to:
  /// **'other diagnose'**
  String get otherDiagnose;

  /// No description provided for @anamnese.
  ///
  /// In en, this message translates to:
  /// **'anamnese'**
  String get anamnese;

  /// No description provided for @enterProtocol.
  ///
  /// In en, this message translates to:
  /// **'Enter Protocol for {patientPrename}'**
  String enterProtocol(Object patientPrename);

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @medicalValues.
  ///
  /// In en, this message translates to:
  /// **'medical values'**
  String get medicalValues;

  /// No description provided for @bloodPressure.
  ///
  /// In en, this message translates to:
  /// **'Bloodpressure in mmHg: '**
  String get bloodPressure;

  /// No description provided for @nibp.
  ///
  /// In en, this message translates to:
  /// **'NIBP'**
  String get nibp;

  /// No description provided for @mmHg.
  ///
  /// In en, this message translates to:
  /// **'mmHg'**
  String get mmHg;

  /// No description provided for @systolic.
  ///
  /// In en, this message translates to:
  /// **'Systolic'**
  String get systolic;

  /// No description provided for @diastolic.
  ///
  /// In en, this message translates to:
  /// **'Diastolic'**
  String get diastolic;

  /// No description provided for @respiratoryRate.
  ///
  /// In en, this message translates to:
  /// **'Respiratory Rate'**
  String get respiratoryRate;

  /// No description provided for @pulse.
  ///
  /// In en, this message translates to:
  /// **'Pulse'**
  String get pulse;

  /// No description provided for @oxygenSaturation.
  ///
  /// In en, this message translates to:
  /// **'Oxygene Saturation'**
  String get oxygenSaturation;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature in °C'**
  String get temperature;

  /// No description provided for @bloodSugar.
  ///
  /// In en, this message translates to:
  /// **'Blood Sugar in mg/dl'**
  String get bloodSugar;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @patientInputTitle.
  ///
  /// In en, this message translates to:
  /// **'Patient Input'**
  String get patientInputTitle;

  /// No description provided for @birthdate.
  ///
  /// In en, this message translates to:
  /// **'birthdate'**
  String get birthdate;

  /// No description provided for @prename.
  ///
  /// In en, this message translates to:
  /// **'prename'**
  String get prename;

  /// No description provided for @surname.
  ///
  /// In en, this message translates to:
  /// **'surname'**
  String get surname;

  /// No description provided for @addPatient.
  ///
  /// In en, this message translates to:
  /// **'Add Patient'**
  String get addPatient;

  /// No description provided for @changePatient.
  ///
  /// In en, this message translates to:
  /// **'Change patient Data'**
  String get changePatient;

  /// No description provided for @errorNotNumeric.
  ///
  /// In en, this message translates to:
  /// **'Enter a Number'**
  String get errorNotNumeric;

  /// No description provided for @errorNoText.
  ///
  /// In en, this message translates to:
  /// **'Please enter a Text'**
  String get errorNoText;

  /// No description provided for @errorDisGreaterSys.
  ///
  /// In en, this message translates to:
  /// **'Diastol can not be greater then Systol'**
  String get errorDisGreaterSys;

  /// No description provided for @noPatients.
  ///
  /// In en, this message translates to:
  /// **'No Patients'**
  String get noPatients;

  /// No description provided for @noTriageCategory.
  ///
  /// In en, this message translates to:
  /// **'No Triage Category'**
  String get noTriageCategory;

  /// No description provided for @emergency.
  ///
  /// In en, this message translates to:
  /// **'emergency'**
  String get emergency;

  /// No description provided for @veryUrgent.
  ///
  /// In en, this message translates to:
  /// **'very urgent'**
  String get veryUrgent;

  /// No description provided for @urgent.
  ///
  /// In en, this message translates to:
  /// **'urgent'**
  String get urgent;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'normal'**
  String get normal;

  /// No description provided for @noUrgent.
  ///
  /// In en, this message translates to:
  /// **'no urgent'**
  String get noUrgent;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'search'**
  String get search;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'no data'**
  String get noData;

  /// No description provided for @waitingArea.
  ///
  /// In en, this message translates to:
  /// **'waiting area'**
  String get waitingArea;

  /// No description provided for @noPatientsFound.
  ///
  /// In en, this message translates to:
  /// **'No patients found'**
  String get noPatientsFound;

  /// No description provided for @dragPatientHere.
  ///
  /// In en, this message translates to:
  /// **'Drag patient here'**
  String get dragPatientHere;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'close'**
  String get close;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'phone'**
  String get phone;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'e-email'**
  String get email;

  /// No description provided for @fax.
  ///
  /// In en, this message translates to:
  /// **'fax'**
  String get fax;

  /// No description provided for @sms.
  ///
  /// In en, this message translates to:
  /// **'sms'**
  String get sms;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'other'**
  String get other;

  /// No description provided for @diagnose.
  ///
  /// In en, this message translates to:
  /// **'diagnose'**
  String get diagnose;

  /// No description provided for @sortTimeDesc.
  ///
  /// In en, this message translates to:
  /// **'Time descending'**
  String get sortTimeDesc;

  /// No description provided for @sortTimeAsc.
  ///
  /// In en, this message translates to:
  /// **'Time ascending'**
  String get sortTimeAsc;

  /// No description provided for @sortAlphabeticalAsc.
  ///
  /// In en, this message translates to:
  /// **'Alphabetical ascending'**
  String get sortAlphabeticalAsc;

  /// No description provided for @sortAlphabeticalDesc.
  ///
  /// In en, this message translates to:
  /// **'Alphabetical descending'**
  String get sortAlphabeticalDesc;

  /// No description provided for @sortUrgency.
  ///
  /// In en, this message translates to:
  /// **'Urgency'**
  String get sortUrgency;

  /// No description provided for @filterNoTreatmentStation.
  ///
  /// In en, this message translates to:
  /// **'Patients without treatment station'**
  String get filterNoTreatmentStation;

  /// No description provided for @filterTreatmentStation.
  ///
  /// In en, this message translates to:
  /// **'Patients with and without treatment station'**
  String get filterTreatmentStation;

  /// No description provided for @filterInactive.
  ///
  /// In en, this message translates to:
  /// **'Only active patients'**
  String get filterInactive;

  /// No description provided for @filterNoInactive.
  ///
  /// In en, this message translates to:
  /// **'Show inactive patients'**
  String get filterNoInactive;

  /// No description provided for @arrivedAt.
  ///
  /// In en, this message translates to:
  /// **'Arrived at'**
  String get arrivedAt;

  /// No description provided for @discharge.
  ///
  /// In en, this message translates to:
  /// **'discharge'**
  String get discharge;

  /// No description provided for @noPatientSelected.
  ///
  /// In en, this message translates to:
  /// **'No patient selected'**
  String get noPatientSelected;

  /// No description provided for @addAnamnese.
  ///
  /// In en, this message translates to:
  /// **'Add anamnese'**
  String get addAnamnese;

  /// No description provided for @finalProtocol.
  ///
  /// In en, this message translates to:
  /// **'send protocol'**
  String get finalProtocol;

  /// No description provided for @overView.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overView;

  /// No description provided for @firstContact.
  ///
  /// In en, this message translates to:
  /// **'first Contact'**
  String get firstContact;

  /// No description provided for @lastContact.
  ///
  /// In en, this message translates to:
  /// **'last contact'**
  String get lastContact;

  /// No description provided for @allProtocolls.
  ///
  /// In en, this message translates to:
  /// **'all protocolls'**
  String get allProtocolls;

  /// No description provided for @downloadProtocol.
  ///
  /// In en, this message translates to:
  /// **'download protocol'**
  String get downloadProtocol;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
