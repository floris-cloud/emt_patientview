import 'package:emt_patientview/src/repository/rest_api.dart';

import '../models/treatment_station.dart';

class TreatmentStationRepository {
  
  static postTreatmentStation(TreatmentStation treatmentStation) async {
    RestApi.postTreatmentStation(treatmentStation);
  }
  static Future<List<TreatmentStation>> getTreatmentStations() async => RestApi.getTreatmentStations();
}