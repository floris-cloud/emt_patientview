import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/treatment_station.dart';
import '../../models/patient.dart';
import 'treatment_station_widget_view.dart';

class TreatmentStationWidgetDrop extends StatelessWidget {
  final TreatmentStation treatmentStation;

  TreatmentStationWidgetDrop({super.key, required this.treatmentStation});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: treatmentStation,
      child: Consumer<TreatmentStation>(
        builder: (context, treatmentStation, child) {
          return DragTarget<Patient>(
            onAcceptWithDetails: (details) {
              treatmentStation.patient = details.data;
              details.data.patTreatmentStationId = treatmentStation.id;
            },
            builder: (context, candidateData, rejectedData) {
              return TreatmentStationView(treatmentStation: treatmentStation);
            },
          );
        },
      ),
    );
  }
}