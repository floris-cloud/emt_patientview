import 'package:emt_patientview/src/models/patient_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/app.dart';
import 'src/models/treatment_station_list.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';


void main() async {
    WidgetsFlutterBinding.ensureInitialized();

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PatientListModel()),
        ChangeNotifierProvider(create: (_) => TreatmentStationList()),
        ChangeNotifierProvider.value(value: settingsController),
      ],
      child: MyApp(),
    ),
  );
}