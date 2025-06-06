import 'package:emt_patientview/src/models/treatment_station_list.dart';
import 'package:flutter/material.dart';
import 'package:emt_patientview/l10n/generated/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'screens/all_patients.dart';
import 'settings/settings_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
   @override
  Widget build(BuildContext context) {

    Provider.of<TreatmentStationList>(context, listen: false).loadTreatmentStations();


return Consumer<SettingsController>(
        builder: (context, settingsController, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            restorationScopeId: 'app',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('de', ''), 
              Locale('en', ''), 
            ],
            locale: settingsController.locale,
            theme: ThemeData(fontFamily: "MavenJohanniter"),
            darkTheme: ThemeData.dark(),
            themeMode: settingsController.themeMode,
            home: AllPatScreen(),
            
          );
        },
    );
  }
}
