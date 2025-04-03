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



   loadTreatmentStations() async {
    _treatmentStations = await TreatmentStationRepository.loadTreatmentStations();
    notifyListeners();
  }
  void removePatientFromTreatmentStation(Patient patient) {
    _treatmentStations.forEach((treatmentStation) {
      treatmentStations.firstWhere((ts) => ts.id == patient.treatmentStationId).patient = null;
    });
    notifyListeners();
  }
  void setShowPatient(Patient patient) {
    print(patient.id);
    showPatient = patient;
    notifyListeners();
  }
  void clearShowPatient() {
    showPatient = null;
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    TreatmentStation old = treatmentStations[oldIndex];
    treatmentStations.removeAt(oldIndex);
    treatmentStations.insert(newIndex, old);
    TreatmentStationRepository.rearrangeTreatmentStations(treatmentStations);

    notifyListeners();
  }
}