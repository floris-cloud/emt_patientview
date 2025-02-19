import 'package:emt_patientview/src/models/patient.dart';
import 'package:flutter/material.dart';
import '../repository/treatment_station_repository.dart';
import 'treatment_station.dart';

class TreatmentStationList extends ChangeNotifier {
  List<TreatmentStation> _treatmentStations = [];
  Patient? showPatient;
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
    TreatmentStationRepository.deleteTreatmentStation(treatmentStation);
    _treatmentStations.remove(treatmentStation);
    
    notifyListeners();
  }



 static  Future<List<TreatmentStation>> loadTreatmentStations() async {

    return await TreatmentStationRepository.getTreatmentStations();
  
  }
  void removePatientFromTreatmentStation(Patient patient) {
    _treatmentStations.forEach((treatmentStation) {
      treatmentStations.firstWhere((ts) => ts.id == patient.treatmentStationId).patient = null;
    });
    notifyListeners();
  }
  void setShowPatient(Patient patient) {
    showPatient = patient;
    notifyListeners();
  }
}