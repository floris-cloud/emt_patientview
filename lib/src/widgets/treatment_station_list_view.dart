import 'package:flutter/material.dart';
import 'package:emt_patientview/l10n/generated/app_localizations.dart';
import '../models/treatment_station_list.dart';
import 'treatment_station_widget/treatment_station_widget_drop.dart';
import 'package:provider/provider.dart';
class TreatmentStationListView extends StatefulWidget {
  const TreatmentStationListView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => TreatmentStationListViewState();
}

class TreatmentStationListViewState extends State<TreatmentStationListView> {


  @override
  Widget build(BuildContext context) {
    TreatmentStationList treatmentStationList = context.watch<TreatmentStationList>();
    return    Column(
          children: [
          Text(AppLocalizations.of(context)!.treatmentStations, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: [
              ...treatmentStationList.treatmentStations.map((treatmentStation) => TreatmentStationWidgetDrop(treatmentStation: treatmentStation)),

          ],
        ),
        ]
        );
  }
}