import 'package:emt_patientview/src/models/patient_list.dart';
import 'package:emt_patientview/src/widgets/patient_list/patient_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';


void main() async {
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
     
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PatientListModel()),
        ChangeNotifierProvider.value(value: settingsController),
      ],
      child: MyApp(),
    ),
  );
}
