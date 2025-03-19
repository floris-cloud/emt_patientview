import 'package:flutter/material.dart';

import '../models/patient.dart';
import '../models/treatment_station.dart';
import '../models/treatment_station_list.dart';
import 'treatment_station_widget/treatment_station_widget_drop.dart';
import 'package:provider/provider.dart';
class TreatmentStationListView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => TreatmentStationListViewState();
}

class TreatmentStationListViewState extends State<TreatmentStationListView> {

  // late  treatmentStationList;
//   @override
// void initState() {
//     super.initState();
//     _loadTreatmentStations();
//   }
//   void _loadTreatmentStations() async {
//     List<TreatmentStation> ts = await TreatmentStationList.loadTreatmentStations();
//     setState(() {
//       treatmentStationList.treatmentStations = ts;
//     });
//   }

  @override
  Widget build(BuildContext context) {
    TreatmentStationList treatmentStationList = context.watch<TreatmentStationList>();
    print(treatmentStationList.treatmentStations.length);
    return    Column(
          children: [
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