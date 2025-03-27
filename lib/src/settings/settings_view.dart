import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/treatment_station_list.dart';
import '../repository/rest_api.dart';
import 'pop_up_treatment_station.dart';
import 'settings_controller.dart';
import 'package:emt_patientview/l10n/generated/app_localizations.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<ThemeMode>(
              value: controller.themeMode,
              onChanged: (ThemeMode? newThemeMode) {
                controller.updateThemeMode(newThemeMode);
              },
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark Theme'),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                RestApi.getMDS();
              },
              child: Text('Download MDS'),
            ),
            DropdownButton<Locale>(
              value: controller.locale,
              onChanged: (Locale? newLocale) {
                controller.updateLocale(newLocale);
              },
              items: const [
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: Locale('de'),
                  child: Text('Deutsch'),
                ),
              ],
            ),
          
            Expanded(
              child: Consumer<TreatmentStationList>(
                builder: (context, treatmentStationList, child) {
                  return ReorderableListView.builder(
                    header: Text('Treatment Places'),
                    onReorder: (oldIndex, newIndex) {
                      treatmentStationList.reorder(oldIndex, newIndex);
                        
                    },
                    itemCount: treatmentStationList.treatmentStations.length,
                    itemBuilder: (context, index) {
                      final treatmentPlace = treatmentStationList.treatmentStations[index];
                      return ListTile(
                        key: ValueKey(treatmentPlace.idString),
                        title: Text(treatmentPlace.id.toString()),
                        subtitle: Text(treatmentPlace.name),
                        trailing: IconButton(icon: Icon(Icons.delete), onPressed: (){
                          treatmentStationList.removeTreatmentStation(treatmentPlace);
                        }),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddTreatmentStationDialog();
                  },
                );
              },
              child: Text('Add Treatment Place'),
            ),
          ],
        ),
      ),
    );
  }
}
