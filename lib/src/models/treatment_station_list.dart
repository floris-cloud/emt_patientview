import 'package:flutter/material.dart';
import '../repository/treatment_station_repository.dart';
import 'treatment_station.dart';

class TreatmentStationList extends ChangeNotifier {
  List<TreatmentStation> _treatmentStations = [];

  List<TreatmentStation> get treatmentStations => _treatmentStations;
  set treatmentStations(List<TreatmentStation> treatmentStations) {
    _treatmentStations = treatmentStations;
    notifyListeners();
  }
  void addTreatmentStation(TreatmentStation treatmentStation) {
    _treatmentStations.add(treatmentStation);
    notifyListeners();
  }

  void removeTreatmentStation(TreatmentStation treatmentStation) {
    _treatmentStations.remove(treatmentStation);
    notifyListeners();
  }

//  static  Future<List<TreatmentStation>> loadTreatmentStations() async {
//     return await TreatmentStationRepository.getTreatmentStations();
  
//   }
}